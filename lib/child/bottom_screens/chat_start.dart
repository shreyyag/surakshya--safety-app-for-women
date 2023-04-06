import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class ChatStart extends StatefulWidget {
  const ChatStart({Key? key}) : super(key: key);

  @override
  State<ChatStart> createState() => _ChatStartState();
}

class _ChatStartState extends State<ChatStart> {
  List<String> messages = []; // list to hold the chat messages
  TextEditingController _messageController =
      TextEditingController(); // controller to handle user input

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: "Enter message",
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  // add the message to the list and clear the text field
                  setState(() {
                    messages.add(_messageController.text);
                    _messageController.clear();
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
