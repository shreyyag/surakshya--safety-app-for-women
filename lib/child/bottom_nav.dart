import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:surakshya/child/bottom_screens/add_contacts.dart';
import 'package:surakshya/child/bottom_screens/chat_screen.dart';
import 'package:surakshya/child/bottom_screens/contacts_screen.dart';
import 'package:surakshya/child/bottom_screens/home_screen.dart';

import '../pages/user_login.dart';
import 'bottom_screens/chat_start.dart';

class BottomNav extends StatefulWidget {
  final token;
  const BottomNav({@required this.token, Key? key}) : super(key: key);
  // const BottomNav({Key? key}) : super(key: key);
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late String number;

  int currentIndex = 0;

  List<Widget> pages = [
    HomeScreen(),
    AddContacts(),
    ChatStart(),
  ];
  onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    number = jwtDecodedToken['number'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Surakshya"),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [PopupMenuItem<int>(value: 0, child: Text("Logout"))];
            },
            onSelected: (value) {
              if (value == 0) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginOptions()));
              }
            },
          )
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onTapped,
        items: [
          BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                Icons.home,
              )),
          // BottomNavigationBarItem(
          //     label: number,
          //     icon: Icon(
          //       Icons.contact_page,
          //     )),
          BottomNavigationBarItem(
              label: 'Contacts',
              icon: Icon(
                Icons.contact_page,
              )),
          BottomNavigationBarItem(
              label: 'Chats',
              icon: Icon(
                Icons.chat_bubble,
              ))
        ],
      ),
    );
  }
}
