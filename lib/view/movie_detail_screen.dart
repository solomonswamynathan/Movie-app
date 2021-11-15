import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/constant/app_size.dart';
import 'package:movies/controller/db_controller.dart';
import 'package:movies/controller/movies_controller.dart';
import 'package:movies/extension/size_extension.dart';
import 'package:movies/view/widgets/movie_detail/movie_cast_card.dart';

import 'widgets/movie_detail/big_poster.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({Key? key}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final MoviesController _moviesController = Get.find();
  final DBController _dbController = Get.find();

  bool _init = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      _init = false;
      getMovieDetails();
    }
  }

  getMovieDetails() async {
    await _moviesController.getMovieDetail();
    await _moviesController.getMovieCast();
    await _dbController.getFavMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(() => BigPoster(movieDetail: _moviesController.movieDetail)),
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.dimen_16.w,
                  vertical: Sizes.dimen_8.h,
                ),
                child: Text(
                  '${_moviesController.movieDetail!.overview}',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
              child: Text(
                'Cast',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Obx(() => MovieCastCard(movieCast: _moviesController.movieCast)),
          ],
        ),
      ),
    );
  }
}
