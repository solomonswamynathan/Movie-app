import 'package:flutter/material.dart';
import 'package:movies/constant/app_size.dart';
import 'package:movies/extension/size_extension.dart';

class NavigationListItem extends StatelessWidget {
  final String? title;
  final Function()? onPressed;

  const NavigationListItem(
      {Key? key, @required this.title, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.7),
              blurRadius: 2,
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: Sizes.dimen_32.w),
          title: Text(
            title!,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ),
    );
  }
}
