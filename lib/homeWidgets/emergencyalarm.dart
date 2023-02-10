import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class EmergencyAlarm extends StatefulWidget {
  const EmergencyAlarm({Key? key}) : super(key: key);

  @override
  State<EmergencyAlarm> createState() => _EmergencyAlarmState();
}

//
class _EmergencyAlarmState extends State<EmergencyAlarm> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
              height: 180,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: const BoxDecoration(),
              child: Image.asset(
                'assets/images/alarm.jpg',
              ))),
      // onTap: () {
      //   PlayState();
      // },
    );
  }
}
