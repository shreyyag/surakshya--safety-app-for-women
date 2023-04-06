import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class ChatStart extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatStart> {
  // TextEditingController _textEditingController = TextEditingController();
  // List<String> _messages = [];
  // late IOWebSocketChannel _channel;

  @override
  // void initState() {
  //   super.initState();
  //   // connect to socket.io server
  //   _channel = IOWebSocketChannel.connect('ws://localhost:3000');

  //   // listen for incoming messages
  //   _channel.stream.listen((message) {
  //     setState(() {
  //       _messages.add(message);
  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   // disconnect from socket.io server when screen is disposed
  //   _channel.sink.close(status.goingAway);
  // }

  // void _sendMessage(String message) {
  //   // send message to backend using socket.io client
  //   _channel.sink.add(jsonEncode({'message': message}));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('Chat'),
    )
        // body: Column(children:

        //       //       child: ListView.builder(
        //       //         itemCount: _messages.length,
        //       //         itemBuilder: (BuildContext context, int index) {
        //       //           return ListTile(
        //       //             title: Text(_messages[index]),
        //       //           );
        //       //         },
        //       //       ),
        //       //     ),
        //       //     TextField(
        //       //       controller: _textEditingController,
        //       //       onSubmitted: (value) {
        //       //         _sendMessage(value);
        //       //       },
        //       //       decoration: InputDecoration(
        //       //         hintText: 'Enter a message',
        //       //         suffixIcon: IconButton(
        //       //           icon: Icon(Icons.send),
        //       //           onPressed: () {
        //       //             _sendMessage(_textEditingController.text);
        //       //             _textEditingController.clear();
        //       //           },
        //       //         ),
        //       //       ),
        //       //     ),
        //       //   ],
        //       // ),
        //       )
        // ]));
        );
  }
}
