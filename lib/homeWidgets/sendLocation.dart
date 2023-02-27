import 'package:background_sms/background_sms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:surakshya/components/primary_button.dart';
import 'package:surakshya/db/db_services.dart';
import 'package:surakshya/utils/contactsm.dart';
// import 'package:sms/sms.dart';

class SendLocation extends StatefulWidget {
  @override
  State<SendLocation> createState() => _SendLocationState();
}

class _SendLocationState extends State<SendLocation> {
  ///////add geolocator and geocoder
  Position? _currentPosition;
  String? _currentAddress;
  LocationPermission? permission;

  /////
  _getPermission() async => await [Permission.sms].request();
  _isPermissionGranted() async => await Permission.sms.status.isGranted;
  //background_sms dependency add
  _sendSms(String phoneNumber, String message, {int? simSlot}) async {
    await BackgroundSms.sendMessage(
            phoneNumber: phoneNumber, message: message, simSlot: simSlot)
        .then((SmsStatus status) {
      if (status == "sent") {
        Fluttertoast.showToast(msg: "Sent");
      } else {
        Fluttertoast.showToast(msg: "Sent");
      }
    });
  }

  //funtion to get current location
  _getCurrentLocation() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      Fluttertoast.showToast(msg: "Location permission accepted.");
      if (permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(msg: "Location permission denied permanently.");
      }
    }
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            //foreground location tracking
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLon();
      });
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  //to get current location
  _getAddressFromLatLon() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            "${place.subLocality}, ${place.subAdministrativeArea},${place.name},${place.postalCode},${place.street}";
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _getPermission();
    _getCurrentLocation();
  }

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
                  if (_currentPosition != null)
                    Text('Your Location: $_currentAddress'),
                  PrimaryButton(
                      btnTitle: "Reload Location",
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
                        String recipients = "";
                        int i = 1;
                        for (TContact contact in contactList) {
                          recipients += contact.number;
                          if (i != contactList.length) {
                            recipients += ";";
                            i++;
                          }
                        }
                        String messageBody =
                            "https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude}%2C${_currentPosition!.longitude}.{$_currentAddress}";
                        if (await _isPermissionGranted()) {
                          contactList.forEach((element) {
                            _sendSms("${element.number}",
                                "HELP! I'm in trouble, please reach me out at $messageBody",
                                simSlot: 1);
                          });
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
