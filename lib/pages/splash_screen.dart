import 'dart:async';

import 'package:flutter/material.dart';
import 'package:surakshya/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // State init
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      // pushReplacement used to add a new screen and replace the old one from the stack
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginOptions(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 111, 185, 115),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splash.png', height: 160,width: 150,),
            Text('Surakshya',
                style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ],
        ),
      ),);
  }
}