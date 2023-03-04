import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/user_login.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text("Surakshya - Admin"),
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
    ));
  }
}
