import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies/services/base_controller.dart';
import 'package:get/get.dart';

class AppController extends GetxController with BaseController {
  // ignore: prefer_final_fields
  Rx<ThemeData> _theme = ThemeData.dark().obs;
  ThemeData get theme => _theme.value;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return;
      } else {
        _user = googleUser;
        final googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (e) {
      print(e);
    }
  }

  Future googleLogout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
