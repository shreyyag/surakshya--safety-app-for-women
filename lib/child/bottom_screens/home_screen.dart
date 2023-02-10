import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surakshya/homeWidgets/emergencyalarm.dart';

import '../../homeWidgets/emergency.dart';
import '../../homeWidgets/locate.dart';
import '../../homeWidgets/sendLocation.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Surakshya')),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Expanded(
            child: ListView(shrinkWrap: true, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Emergency",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Emergency(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Explore Locations",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              LiveSafe(),
              SendLocation(),
              EmergencyAlarm()
            ]),
          ),
        ]),
      )),
    );
  }
}
