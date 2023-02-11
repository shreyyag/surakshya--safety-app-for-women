import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmergencyAlarm extends StatefulWidget {
  const EmergencyAlarm({Key? key}) : super(key: key);

  @override
  State<EmergencyAlarm> createState() => _EmergencyAlarmState();
}

//
class _EmergencyAlarmState extends State<EmergencyAlarm> {
  final player = AudioPlayer();
  bool isplaying = false;

  @override
  void initState(){
    super.initState();
    player.onPlayerStateChanged.listen((state) {
      isplaying = state == PlayerState.playing;
    });
  }
  @override
  void dispose(){
    player.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
            height: 160,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: const BoxDecoration(),
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset('assets/images/alarm.jpg',
                        height: 160, width: 230)),
                Expanded(child: CircleAvatar(
                  radius: 30,
                  child: IconButton(
                    icon: Icon(
                        isplaying ? Icons.stop : Icons.play_arrow
                    ),
                    iconSize: 33,
                    onPressed: (){
                      if(isplaying){
                        player.stop();
                      }else{
                        player.play(AssetSource('audio/emergencyAlarm.mp3'));
                      }
                    },
                  ),
                ),),

              ],
            ),


        ));
  }
}
