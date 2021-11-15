import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/constant/app_color.dart';
import 'package:movies/constant/app_size.dart';
import 'package:movies/extension/size_extension.dart';
import 'package:movies/util/screen_util.dart';
import 'package:movies/view/widgets/logo.dart';

import '../search_movie.dart';

class MoviesAppBar extends StatelessWidget {
  const MoviesAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil.statusBarHeight + Sizes.dimen_4.h,
        left: Sizes.dimen_16.w,
        right: Sizes.dimen_16.w,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: SvgPicture.asset(
              'assets/svgs/menu.svg',
              height: Sizes.dimen_12.h,
              // color: context.read<ThemeCubit>().state == Themes.dark
              //     ? Colors.white
              //     : AppColor.vulcan,
            ),
          ),
          const Expanded(child: Logo(height: Sizes.dimen_14)),
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchMovies());
            },
            icon: Icon(
              Icons.search,
              color: AppColor.white,
              // color: context.read<ThemeCubit>().state == Themes.dark
              //     ? Colors.white
              //     : AppColor.vulcan,
              size: Sizes.dimen_12.h,
            ),
          ),
        ],
      ),
    );
  }
}
