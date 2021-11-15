import 'package:flutter/material.dart';
import 'package:movies/constant/app_color.dart';
import 'package:movies/constant/app_size.dart';
import 'package:movies/constant/app_text_theme.dart';
import 'package:movies/extension/size_extension.dart';

class TabTitle extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  final bool? isSelected;

  const TabTitle(
      {Key? key,
      @required this.title,
      @required this.onTap,
      this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: isSelected! ? AppColor.royalBlue : Colors.transparent,
              width: Sizes.dimen_1.h,
            ),
          ),
        ),
        child: Text(
          title!, //'popular', 'now', 'soon'
          style: isSelected!
              ? Theme.of(context).textTheme.royalBlueSubtitle1
              : Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}
