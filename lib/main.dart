import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gallery/domain/user.dart';
import 'package:flutter_gallery/screens/checking.dart';
import 'package:flutter_gallery/screens/splash.dart';
import 'package:flutter_gallery/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    '/Check': (BuildContext context) => CheckingPage()
  };

  @override
  Widget build(BuildContext context) {
    return StreamProvider<GalleryUser>.value(
      value: AuthService().currentUser,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(nextRoute: '/Check'),
        routes: routes,
      ),
    );
  }
}
