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
import 'chat_start.dart';

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
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChatStart()));
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
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  checkNumberExists(contactList[index].number);
                                },
                                icon: Icon(
                                  Icons.chat,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  deleteContact(contactList[index]);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            checkNumberExists(contactList[index].number);
                          },
                        ),
                      ));
                    }),
              ),
            ])));
  }
}




























