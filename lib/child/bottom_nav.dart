import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:surakshya/child/bottom_screens/add_contacts.dart';
import 'package:surakshya/child/bottom_screens/chat_screen.dart';
import 'package:surakshya/child/bottom_screens/contacts_screen.dart';
import 'package:surakshya/child/bottom_screens/home_screen.dart';

class BottomNav extends StatefulWidget {
  // final token;
  // const BottomNav({@required this.token, Key? key}) : super(key: key);
  const BottomNav({Key? key}) : super(key: key);
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late String email;

  int currentIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    AddContacts(),
    ChatScreen(),
  ];
  onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    // email = jwtDecodedToken['email'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
