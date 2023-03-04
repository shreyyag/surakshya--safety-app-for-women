import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class ChatStart extends StatefulWidget {
  const ChatStart({Key? key}) : super(key: key);

  @override
  State<ChatStart> createState() => _ChatStartState();
}

class _ChatStartState extends State<ChatStart> {
  TextEditingController msgInputController = TextEditingController();
  // final store = new Store(reducer,
  //  initialState: ChatState(

  //  ))

  // void sendMessage() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Guardian"),
        ),
        body: StreamBuilder(
          // stream: ,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: ListTile(),
                    ),
                  );
                });
          },
        ));
  }
}
