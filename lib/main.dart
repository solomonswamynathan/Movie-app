import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movies/constant/app_color.dart';
import 'package:movies/util/screen_util.dart';

import 'constant/app_text_theme.dart';
import 'controller/app_controller.dart';

import 'package:firebase_core/firebase_core.dart';

import 'view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  await Firebase.initializeApp();
  runApp(MoviesApp());
}

class MoviesApp extends StatelessWidget {
  MoviesApp({Key? key}) : super(key: key);
  final AppController _appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    var theme = _appController.theme;
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          unselectedWidgetColor: AppColor.royalBlue,
          primaryColor:
              theme == ThemeData.dark() ? AppColor.vulcan : Colors.white,
          accentColor: AppColor.royalBlue,
          scaffoldBackgroundColor:
              theme == ThemeData.dark() ? AppColor.vulcan : Colors.white,
          brightness:
              theme == ThemeData.dark() ? Brightness.dark : Brightness.light,
          cardTheme: CardTheme(
            color: theme == ThemeData.dark() ? Colors.white : AppColor.vulcan,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: theme == ThemeData.dark()
              ? ThemeText.getTextTheme()
              : ThemeText.getLightTextTheme(),
          appBarTheme: const AppBarTheme(elevation: 0),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: Theme.of(context).textTheme.greySubtitle1,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color:
                    theme == ThemeData.dark() ? Colors.white : AppColor.vulcan,
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        home: const SplashScreen());
  }
}
