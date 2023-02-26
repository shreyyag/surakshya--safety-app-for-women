import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msgInputController = TextEditingController();
  // final store = new Store(reducer,
  //  initialState: ChatState(

  //  ))

  // void sendMessage() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          Expanded(flex: 9, child: Container()),
          Expanded(
              child: Container(
            padding: EdgeInsets.all(10),
            color: Colors.pink,
            child: TextField(
              controller: msgInputController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white)),
                  suffixIcon: Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    color: Colors.yellow,
                    child: IconButton(
                      onPressed: () {
                        // sendMessage(msgInputController.text),
                        // msgInputController.text = "";
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  )),
            ),
          ))
        ],
      ),
    ));
  }
}
