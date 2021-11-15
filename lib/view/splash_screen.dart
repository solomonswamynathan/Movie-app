import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies/constant/app_size.dart';
import 'package:movies/extension/size_extension.dart';
import 'package:movies/view/widgets/auth_director.dart';

import 'widgets/logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const AuthDirectory()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: Sizes.dimen_8.h,
            bottom: Sizes.dimen_18.h,
            left: Sizes.dimen_8.w,
            right: Sizes.dimen_8.w,
          ),
          child: Logo(
            height: Sizes.dimen_20.h,
          ),
        ),
      ),
    );
  }
}
