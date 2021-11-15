import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies/constant/app_size.dart';
import 'package:movies/extension/size_extension.dart';
import 'package:movies/util/screen_util.dart';
import 'package:movies/view/widgets/movie_carousel/movie_card.dart';

class AnimatedMovieCard extends StatefulWidget {
  final int? index;
  final int? movieId;
  final String? posterPath;
  final PageController? pageController;

  const AnimatedMovieCard(
      {Key? key,
      @required this.index,
      @required this.movieId,
      @required this.posterPath,
      @required this.pageController})
      : super(key: key);

  @override
  State<AnimatedMovieCard> createState() => _AnimatedMovieCardState();
}

class _AnimatedMovieCardState extends State<AnimatedMovieCard> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      Timer(const Duration(milliseconds: 2), () {
        testFunction();
      });
    }
    _init = false;
  }

  testFunction() {
    setState(() {});
  }

  bool _init = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.pageController!,
      builder: (context, child) {
        double value = 1;
        if (widget.pageController!.position.haveDimensions) {
          value = (widget.pageController!.page ?? 0) - widget.index!;
          value = (1 - (value.abs() * 0.1)).clamp(0.0, 1.0);
          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: Curves.easeIn.transform(value) *
                  ScreenUtil.screenHeight *
                  0.35,
              width: Sizes.dimen_230.w,
              child: child,
            ),
          );
        } else {
          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: Curves.easeIn
                      .transform(widget.index == 0 ? value : value * 0.5) *
                  ScreenUtil.screenHeight *
                  0.35,
              width: Sizes.dimen_230.w,
              child: child,
            ),
          );
        }
      },
      child: MovieCard(
        movieId: widget.movieId,
        posterPath: widget.posterPath,
      ),
    );
  }
}
