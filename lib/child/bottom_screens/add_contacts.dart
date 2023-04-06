import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:surakshya/child/bottom_screens/contacts_screen.dart';
import 'package:surakshya/components/primary_button.dart';
import 'package:surakshya/config.dart';
import 'package:surakshya/db/db_services.dart';

import '../../utils/contactsm.dart';

class AddContacts extends StatefulWidget {
  const AddContacts({Key? key}) : super(key: key);

  @override
  State<AddContacts> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  DbHelper databasehelper = DbHelper();
  List<TContact> contactList = [];
  int count = 0;

  void showList() async {
    Database? database = await databasehelper.initializeDatabase();
    List<TContact> contacts = await databasehelper.getContactList();
    setState(() {
      contactList = contacts;
      count = contactList.length;
    });
  }

  void checkNumberExists(String number) async {
    var reqBody = {"number": number};
    var response = await http.post(
      Uri.parse(numberExists),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      var myToken = jsonResponse['token'];
      var userRole = jsonResponse['role'];
      Fluttertoast.showToast(msg: "User has an account.");
    } else {
      Fluttertoast.showToast(msg: jsonResponse['message']);
    }
  }

  void deleteContact(TContact contact) async {
    int result = await databasehelper.deleteContact(contact.id);
    if (result != 0) {
      Fluttertoast.showToast(msg: "Contact removed successfully");
      showList();
    }
  }

  @override
  void initState() {
    super.initState();
    showList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            padding: EdgeInsets.all(12),
            child: Column(children: [
              PrimaryButton(
                btnTitle: "Add Trusted Contacts",
                onPressed: () async {
                  bool? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactsScreen(),
                    ),
                  );
                  if (result != null && result == true) {
                    showList();
                  }
                },
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: count,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: InkWell(
                          child: ListTile(
                            title: Text(contactList[index].name),
                            trailing: IconButton(
                                onPressed: () {
                                  deleteContact(contactList[index]);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                          ),
                          onTap: () {
                            checkNumberExists(contactList[index].number);
                          },
                        ),
                      );
                    }),
              )
            ])));
  }
}


































//   DbHelper databasehelper = DbHelper();
//   List<TContact> contactList = [];
//   int count = 0;

//   void showList() {
//     Future<Database> dbFuture = databasehelper.initializeDatabase();
//     dbFuture.then((database) {
//       Future<List<TContact>> contactListFuture =
//           databasehelper.getContactList();
//       contactListFuture.then((value) {
//         setState(() {
//           this.contactList = value;
//           this.count = value.length;
//         });
//       });
//     });
//   }

//   Future<bool> checkNumber(String number) async {
//     var reqBody = {
//       "number": number,
//     };
//     var response = await http.post(Uri.parse(numberExists),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(reqBody));
//     var jsonResponse = jsonDecode(response.body);
//     if (jsonResponse['status']) {
//       var myToken = jsonResponse['token'];
//       var userRole = jsonResponse['role'];
//       return true;
//     } else {
//       return false;
//     }
//   }
//   void checkNumber() async {
//     if (// number exists) {
//       var reqBody = {
//         "number": numberController.text,
//       };

//       var response = await http.post(Uri.parse(numberExists),
//           headers: {"Content-Type": "application/json"},
//           body: jsonEncode(reqBody));
//       var jsonResponse = jsonDecode(response.body);
//       //Saving token in shared preference
//       if (jsonResponse['status']) {
//         var myToken = jsonResponse['token'];
//         var userRole = jsonResponse['role'];

//         // prefs.setString("token", myToken);
//         // prefs.setString("role", userRole);
//         Fluttertoast.showToast(msg: "Loging in");

//         if (jsonResponse) {
//           Fluttertoast.showToast(msg: "Number exists in db.");
//         } else {
//           Fluttertoast.showToast(msg: "Number doesn't exist in db.");
//         }
//       } else {
//         Fluttertoast.showToast(msg: "Something went wrong!");
//       }
//     }
//   }

//   void deleteContact(TContact contact) async {
//     int result = await databasehelper.deleteContact(contact.id);
//     if (result != 0) {
//       Fluttertoast.showToast(msg: "Contact removed sucessfully");
//       showList();
//     }
//   }

//   @override
//   void initState() {
//     showList();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         padding: EdgeInsets.all(12),
//         child: Column(
//           children: [
//             PrimaryButton(
//                 btnTitle: "Add Trusted Contacts",
//                 onPressed: () async {
//                   //on clicking this button navigated to contacts screen
//                   bool result = await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => ContactsScreen()));
//                   if (result == true) {
//                     showList();
//                   }
//                 }),
//             //creating list to display the emergency contact list
//             Expanded(
//               child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: count,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Card(
//                       child: ListTile(
//                         title: Text(contactList[index].name),
//                         trailing: IconButton(
//                             onPressed: () {
//                               deleteContact(contactList[index]);
//                             },
//                             icon: Icon(
//                               Icons.delete,
//                               color: Colors.red,
//                             )),
//                       ),
                      
//                     );
//                   }),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
