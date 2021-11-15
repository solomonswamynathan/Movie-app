import 'package:flutter/material.dart';
import 'package:movies/constant/app_color.dart';
import 'package:movies/constant/app_size.dart';
import 'package:movies/extension/size_extension.dart';

class Seperator extends StatelessWidget {
  const Seperator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.dimen_1.h,
      width: Sizes.dimen_80.w,
      padding: EdgeInsets.only(
        top: Sizes.dimen_2.h,
        bottom: Sizes.dimen_6.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_1.h)),
        gradient: const LinearGradient(
          colors: [
            AppColor.violet,
            AppColor.royalBlue,
          ],
        ),
      ),
    );
  }
}
