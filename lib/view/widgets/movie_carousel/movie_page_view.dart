import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/constant/app_size.dart';
import 'package:movies/controller/movies_controller.dart';
import 'package:movies/extension/size_extension.dart';
import 'package:movies/model/movies.dart';
import 'package:movies/util/screen_util.dart';
import 'package:movies/view/widgets/movie_carousel/animated_movie_card.dart';

class MoviePageView extends StatefulWidget {
  const MoviePageView({Key? key}) : super(key: key);

  @override
  State<MoviePageView> createState() => _MoviePageViewState();
}

class _MoviePageViewState extends State<MoviePageView> {
  PageController? _pageController;
  final MoviesController _moviesController = Get.find();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 1,
      keepPage: false,
      viewportFraction: 0.7,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Sizes.dimen_10.h),
      height: ScreenUtil.screenHeight * 0.35,
      child: Obx(
        () => _moviesController.movies!.results != null
            ? PageView.builder(
                controller: _pageController,
                itemCount: _moviesController.movies!.results!.length,
                itemBuilder: (context, index) {
                  Results movies = _moviesController.movies!.results![index];

                  return AnimatedMovieCard(
                    movieId: movies.id,
                    posterPath: movies.posterPath,
                    pageController: _pageController,
                    index: index,
                  );
                },
                pageSnapping: true,
                onPageChanged: (index) {
                  _moviesController.currentMovieInDisplay.value =
                      _moviesController.movies!.results![index];
                },
              )
            : Container(),
      ),
    );
  }
}
