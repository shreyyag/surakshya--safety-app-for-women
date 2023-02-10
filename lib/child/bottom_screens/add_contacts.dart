import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:surakshya/child/bottom_screens/contacts_screen.dart';
import 'package:surakshya/components/primary_button.dart';
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

  void showList() {
    Future<Database> dbFuture = databasehelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<TContact>> contactListFuture =
          databasehelper.getContactList();
      contactListFuture.then((value) {
        setState(() {
          this.contactList = value;
          this.count = value.length;
        });
      });
    });
  }

  void deleteContact(TContact contact) async {
    int result = await databasehelper.deleteContact(contact.id);
    if (result != 0) {
      Fluttertoast.showToast(msg: "Contact removed sucessfully");
      showList();
    }
  }

  @override
  void initState() {
    showList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            PrimaryButton(
                btnTitle: "Add Trusted Contacts",
                onPressed: () async {
                  //on clicking this button navigated to contacts screen
                  bool result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContactsScreen()));
                  if (result == true) {
                    showList();
                  }
                }),
            //creating list to display the emergency contact list
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: count,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
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
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
