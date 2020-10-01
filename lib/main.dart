import 'package:flutter_gallery/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gallery/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    '/List': (BuildContext context) => ListOfImages()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(nextRoute: '/List'),
      routes: routes,
    );
  }
}
