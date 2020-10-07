import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gallery/domain/user.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<GalleryUser> signInWithEmailAndPassword(
      String email, String pass) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: pass);
      User user = result.user;
      return GalleryUser.fromFireBase(user);
    } catch (e) {
      return null;
    }
  }

  Future<GalleryUser> registerWithEmailAndPassword(
      String email, String pass) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: pass);
      User user = result.user;
      return GalleryUser.fromFireBase(user);
    } catch (e) {
      return null;
    }
  }

  Future logOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<GalleryUser> get currentUser {
    return _firebaseAuth.authStateChanges().map(
        (User user) => user != null ? GalleryUser.fromFireBase(user) : null);
  }
}
