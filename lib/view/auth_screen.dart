import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:movies/constant/app_color.dart';
import 'package:movies/constant/app_size.dart';
import 'package:movies/controller/app_controller.dart';
import 'package:movies/extension/size_extension.dart';

import 'widgets/logo.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AppController _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: Sizes.dimen_100.h),
              child: Logo(
                key: const ValueKey('logo_key'),
                height: Sizes.dimen_24.h,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: Sizes.dimen_8.h),
              child: Text(
                "Login to Movie App",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            const SizedBox(height: Sizes.dimen_300),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_60),
              child: ElevatedButton.icon(
                icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                style: ElevatedButton.styleFrom(
                    primary: AppColor.white,
                    onPrimary: Colors.black,
                    minimumSize: const Size(double.infinity, 50)),
                label: const Text('Sign In with Google'),
                onPressed: () async {
                  await _appController.googleLogin();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
