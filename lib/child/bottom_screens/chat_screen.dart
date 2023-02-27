import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msgInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
