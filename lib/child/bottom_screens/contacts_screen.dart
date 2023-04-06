import 'dart:convert';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:surakshya/child/bottom_screens/add_contacts.dart';
import 'package:surakshya/db/db_services.dart';

import '../../config.dart';
import '../../utils/constants.dart';
import '../../utils/contactsm.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);
  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  // CREATING LIST FOR to store Contacts & Filtered contacts, USING CONTACT_SERVICES DEPENDENCY
  List<Contact> contacts = [];
  List<Contact> filteredContacts = [];

  DbHelper _databaseHelper = DbHelper();
  // FOR SEARCH CONTROLLER
  TextEditingController searchController = TextEditingController();
  @override
  // askPermissions() function is initialized first
  void initState() {
    super.initState();
    askPermissions();
  }

  // String flattenPhoneNumber(String phoneStr) {
  //   return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
  //     return m[0] == "+" ? "+" : "";
  //   });
  // }

  //function to filter contact
  filterContact() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    // if (searchController.text.isNotEmpty) {
    //   _contacts.retainWhere((element) {
    //     String searchTerm = searchController.text.toLowerCase();
    //     // String searchTermFlattern = flattenPhoneNumber(searchTerm);
    //     String contactName = element.displayName!.toLowerCase();
    //     bool nameMatched = contactName.contains(searchTerm);
    //     if (nameMatched == true) {
    //       return true;
    //     }
    //     if (searchTermFlattern.isEmpty) {
    //       return false;
    //     }
    //     var phone = element.phones!.firstWhere((p) {
    //       String phnFlattered = flattenPhoneNumber(p.value!);
    //       return phnFlattered.contains(searchTermFlattern);
    //     });
    //     return phone.value != null;
    //   });
    // }
    setState(() {
      filteredContacts = _contacts;
    });
  }

  //TO GET ALL CONTACTS
  Future<void> askPermissions() async {
    PermissionStatus permissionStatus = await getContactsPermissions();
    if (permissionStatus == PermissionStatus.granted) {
      getAllContacts();
    } else {
      handInvalidPermissions(permissionStatus);
    }
  }

  handInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      dialogueBox(
          context, "Access to the contacts has been denied by the user");
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      dialogueBox(context, "Contact does not exist in the device.");
    }
  }

  //ASKS PERMISSION TO GET ALL CONTACT LIST
  Future<PermissionStatus> getContactsPermissions() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  //GETS ALL CONTACTS OF THE DEVICE
  getAllContacts() async {
    List<Contact> _contacts =
        await ContactsService.getContacts(withThumbnails: false);
    setState(() {
      contacts = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    //search controller
    bool isSearchIng = searchController.text.isNotEmpty;
    bool listItemExist = (filteredContacts.length > 0 || contacts.length > 0);
    return Scaffold(
        body: contacts.length == 0
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TextField(
                    //     autofocus: true,
                    //     controller: searchController,
                    //     decoration: InputDecoration(
                    //         labelText: "Search contact",
                    //         prefixIcon: Icon(Icons.search)),
                    //   ),
                    // ),
                    listItemExist == true
                        ? Expanded(
                            child: ListView.builder(
                                itemCount: isSearchIng == true
                                    ? filteredContacts.length
                                    : contacts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Contact contact = isSearchIng == true
                                      ? filteredContacts[index]
                                      : contacts[index];
                                  return ListTile(
                                    title: Text(contact.displayName!),
                                    leading:
                                        // TO DISPLAY CIRCULAR AVATAR OF THE CONTACTS
                                        contact.avatar != null &&
                                                contact.avatar!.length > 0
                                            ? CircleAvatar(
                                                backgroundColor: Colors.green,
                                                backgroundImage: MemoryImage(
                                                    contact.avatar!),
                                              )
                                            : CircleAvatar(
                                                backgroundColor: Colors.green,
                                                child: Text(contact.initials()),
                                              ),
                                    onTap: () {
                                      if (contact.phones!.length > 0) {
                                        final String phoneNum =
                                            contact.phones!.elementAt(0).value!;
                                        final String name =
                                            contact.displayName!;
                                        _addContact(TContact(phoneNum, name));
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Sorry! phone number of this contact does not exist.");
                                      }
                                      // Navigator.of(context).pop();
                                    },
                                  );
                                }),
                          )
                        : Container(
                            child: Text("searching"),
                          )
                  ],
                ),
              ));
  }

  void _addContact(TContact newContact) async {
    int result = await _databaseHelper.insertContact(newContact);
    if (result != 0) {
      Fluttertoast.showToast(msg: "Emergency contact added successfully");
    } else {
      Fluttertoast.showToast(msg: "Failed to add contact.");
    }
    Navigator.of(context).pop(true);
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => AddContacts()));
  }
}
