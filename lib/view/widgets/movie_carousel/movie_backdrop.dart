import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/constant/app_size.dart';
import 'package:movies/controller/movies_controller.dart';
import 'package:movies/extension/size_extension.dart';
import 'package:movies/util/screen_util.dart';

import '../../../app_url.dart' as app_url;

class MovieBackdrop extends StatelessWidget {
  MovieBackdrop({Key? key}) : super(key: key);

  final MoviesController _moviesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topCenter,
      heightFactor: 0.7,
      child: ClipRRect(
        borderRadius:
            BorderRadius.vertical(bottom: Radius.circular(Sizes.dimen_40.w)),
        child: Stack(
          children: [
            Obx(
              () {
                String? backdropPath =
                    _moviesController.currentMovieInDisplay.value.backdropPath;
                return backdropPath != null
                    ? FractionallySizedBox(
                        heightFactor: 1,
                        widthFactor: 1,
                        child: CachedNetworkImage(
                          imageUrl: '${app_url.baseImageUrl}$backdropPath',
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    : const SizedBox.shrink();
              },
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                  width: ScreenUtil.screenWidth,
                  height: 1,
                  color: Colors.transparent),
            ),
          ],
        ),
      ),
    );
  }
}
