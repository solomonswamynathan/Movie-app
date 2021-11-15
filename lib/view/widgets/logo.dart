import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double? height;

  const Logo({Key? key, @required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/pngs/logo.png',
      color: Colors.white,
      height: height,
    );
  }
}
