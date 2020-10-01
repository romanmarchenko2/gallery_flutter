import 'dart:core';
import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final String nextRoute;

  SplashScreen({this.nextRoute});
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed(widget.nextRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.topLeft,
              colors: [Colors.blue, Colors.pink])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Flutter Gallery',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  decoration: TextDecoration.none)),
          Image.asset('images/galleryIcon.png',
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.5),
          CircularProgressIndicator(
            backgroundColor: Colors.white,
            strokeWidth: 4,
          )
        ],
      ),
    );
  }
}
