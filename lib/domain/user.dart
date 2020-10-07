import 'package:firebase_auth/firebase_auth.dart';

class GalleryUser {
  String id;

  GalleryUser.fromFireBase(User user) {
    id = user.uid;
  }
}
