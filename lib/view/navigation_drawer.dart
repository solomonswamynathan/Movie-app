import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/constant/app_size.dart';
import 'package:movies/controller/app_controller.dart';
import 'package:movies/extension/size_extension.dart';
import 'package:movies/view/fav_screen.dart';
import 'package:movies/view/widgets/auth_director.dart';

import 'widgets/drawer/navigation_list_item.dart';
import 'widgets/logo.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key? key}) : super(key: key);

  final AppController _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            blurRadius: 4,
          ),
        ],
      ),
      width: Sizes.dimen_300.w,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
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
                const Spacer(),
                InkWell(
                  onTap: () async {
                    await _appController.googleLogout();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const AuthDirectory()),
                        (route) => false);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: Sizes.dimen_8.h,
                      bottom: Sizes.dimen_18.h,
                      left: Sizes.dimen_8.w,
                      right: Sizes.dimen_8.w,
                    ),
                    child: const Text('Sign out'),
                  ),
                )
              ],
            ),
            NavigationListItem(
              title: 'Watch list',
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const FavScreen()));
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
