import 'package:flutter/material.dart';
import 'package:flutter_gallery/domain/user.dart';
import 'package:flutter_gallery/screens/auth.dart';
import 'package:flutter_gallery/screens/home.dart';
import 'package:provider/provider.dart';

class CheckingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GalleryUser user = Provider.of<GalleryUser>(context);
    final bool isLoggedIn = user != null;
    return isLoggedIn ? FetchImages() : AutorizationPage();
  }
}
