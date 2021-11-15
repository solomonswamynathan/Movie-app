import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/view/auth_screen.dart';
import 'package:movies/view/home_screen.dart';

class AuthDirectory extends StatelessWidget {
  const AuthDirectory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return const HomeScreen();
        } else if (snapshot.hasError) {
          return const Center(
            child: Material(child: Text('Something went wrong')),
          );
        } else {
          return const AuthScreen();
        }
      },
    );
  }
}
