import 'package:background_sms/background_sms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:surakshya/components/primary_button.dart';
import 'package:surakshya/db/db_services.dart';
import 'package:surakshya/utils/contactsm.dart';
// import 'package:sms/sms.dart';

class Location extends StatefulWidget {
  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  ///////add geolocator and geocoder
  Position? _currentPosition;
  String? _currentAddress;
  LocationPermission? permission;
  bool _isLoading = false;
  bool _mounted = false;

  @override
  void initState() {
    super.initState();
    _mounted = true;
    _getPermission();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  /////
  Future<void> _getPermission() async {
    final status = await Permission.sms.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      Fluttertoast.showToast(msg: "SMS permission denied.");
      return;
    }
  }

  // Function to check if permission for sending SMS is granted
  Future<bool> _isPermissionGranted() async {
    final status = await Permission.sms.status;
    return status.isGranted;
  }

  //background_sms dependency add
  // Future<void> _sendSms(String phoneNumber, String message,
  //     {int? simSlot}) async {
  //   try {
  //     final status = await BackgroundSms.sendMessage(
  //       phoneNumber: phoneNumber,
  //       message: message,
  //       simSlot: simSlot,
  //     );
  //     if (status == SmsStatus.sent) {
  //       Fluttertoast.showToast(msg: "Sent");
  //     } else {
  //       Fluttertoast.showToast(msg: "Sending!");
  //     }
  //   } on Exception catch (e) {
  //     Fluttertoast.showToast(msg: "Failed to send message: ${e.toString()}");
  //   }
  // }

// ...

  Future<void> _sendSms(List<String> phoneNumbers, String messageBody) async {
    try {
      await sendSMS(
        message: messageBody,
        recipients: phoneNumbers,
      );
      Fluttertoast.showToast(msg: "Proccessing");
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to send message: ${e.toString()}");
    }
  }

  //funtion to get current location
  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true; // set isLoading to true to show the loading indicator
    });

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(msg: "Location permission denied permanently.");
        setState(() {
          _isLoading = false; // hide the loading indicator
        });
        return;
      } else if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: "Location permission denied.");
        setState(() {
          _isLoading = false; // hide the loading indicator
        });
        return;
      } else {
        Fluttertoast.showToast(msg: "Location permission accepted.");
      }
    } else {
      try {
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          forceAndroidLocationManager: true,
        );
        setState(() {
          _currentPosition = position;
        });
        await _getAddressFromLatLon();
      } catch (e) {
        Fluttertoast.showToast(
            msg: "Failed to get current location: ${e.toString()}");
      }
    }

    setState(() {
      _isLoading = false; // hide the loading indicator
    });
  }

  //to get current location
  Future<void> _getAddressFromLatLon() async {
    try {
      final placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      if (placemarks.isEmpty) {
        setState(() {
          _currentAddress = "Unknown address";
        });
      } else {
        final place = placemarks[0];
        setState(() {
          _currentAddress =
          "${place.subLocality}, ${place.subAdministrativeArea}, ${place.name}, ${place.postalCode}, ${place.street}";
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to get address: ${e.toString()}");
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _getPermission();
  //   _getCurrentLocation();
  // }

  showModelSafeHome(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height / 1.4,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "SEND YOUR CURRENT LOCATION TO YOUR EMERGENCY CONTACT.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  Image.asset('assets/images/sendloaction.png',
                      height: 160, width: 230),
                  SizedBox(
                    height: 30,
                  ),
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Text('  Your Location: $_currentAddress',
                      style: TextStyle(color: Colors.red)),
                  PrimaryButton(
                      btnTitle: "Get Location",
                      onPressed: () {
                        _getCurrentLocation();
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  PrimaryButton(
                      btnTitle: "Send SMS",
                      onPressed: () async {
                        List<TContact> contactList =
                        await DbHelper().getContactList();
                        List<String> recipients = [];
                        int i = 1;
                        for (TContact contact in contactList) {
                          recipients.add(contact.number);
                          // if (i != contactList.length) {
                          //   recipients += ";";
                          //   i++;
                          // }
                        }
                        String messageBody =
                            "https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude}%2C${_currentPosition!.longitude}.{$_currentAddress}";
                        if (await _isPermissionGranted()) {
                          // for (TContact element in contactList) {
                          try {
                            await _sendSms(
                              recipients,
                              "HELP! I'm in trouble, please reach me out at $messageBody",
                            );
                          } catch (e) {
                            Fluttertoast.showToast(
                                msg:
                                "Failed to send message to${e.toString()}");
                          }
                          // }
                        } else {
                          Fluttertoast.showToast(msg: "Something went wrong!");
                        }
                      })
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: 180,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(),
          child: Row(children: [
            Expanded(
                child: Column(children: [
                  ListTile(
                    title: Text("Send Location"),
                    subtitle: Text("Share Location"),
                  ),
                ])),
            ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset('assets/images/sendloaction.png',
                    height: 80, width: 230))
          ]),
        ),
      ),
      onTap: () => showModelSafeHome(context),
    );
  }
}
