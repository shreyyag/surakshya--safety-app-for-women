import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/user_login.dart';

class ParentHomePage extends StatefulWidget {
  const ParentHomePage({Key? key}) : super(key: key);

  @override
  State<ParentHomePage> createState() => _ParentHomePageState();
}

class _ParentHomePageState extends State<ParentHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Child"),
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
      body: Text("Parent Screen"),
    );
  }
}
