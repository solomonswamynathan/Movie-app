import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/constant/app_color.dart';
import 'package:movies/controller/movies_controller.dart';

class MovieTitle extends StatelessWidget {
  MovieTitle({Key? key}) : super(key: key);

  final MoviesController _moviesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        _moviesController.currentMovieInDisplay.value.title ?? '',
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.fade,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: AppColor.white),
      ),
    );
  }
}
