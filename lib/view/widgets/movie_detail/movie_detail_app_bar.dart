import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/constant/app_color.dart';
import 'package:movies/constant/app_size.dart';
import 'package:movies/controller/db_controller.dart';
import 'package:movies/extension/size_extension.dart';
import 'package:movies/model/fav.dart';

class MovieDetailAppBar extends StatelessWidget {
  final Fav? favourite;

  MovieDetailAppBar({
    Key? key,
    this.favourite,
  }) : super(key: key);

  final DBController _dbController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColor.white,
            size: Sizes.dimen_12.h,
          ),
        ),
        Obx(
          () {
            List<Fav> fav = _dbController.favMovies
                .where((element) => element.id == favourite!.id)
                .toList();
            return GestureDetector(
              onTap: () {
                if (fav.isNotEmpty) {
                  _dbController.removeMovieFromFav(movie: favourite);
                } else {
                  _dbController.addMovieToFav(movie: favourite);
                }
              },
              child: fav.isNotEmpty
                  ? Icon(
                      Icons.favorite,
                      color: AppColor.white,
                      size: Sizes.dimen_12.h,
                    )
                  : Icon(
                      Icons.favorite_border,
                      color: AppColor.white,
                      size: Sizes.dimen_12.h,
                    ),
            );
          },
        ),
      ],
    );
  }
}
