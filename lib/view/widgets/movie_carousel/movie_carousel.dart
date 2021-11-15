import 'package:flutter/material.dart';
import 'package:movies/view/widgets/movie_carousel/movie_backdrop.dart';
import 'package:movies/view/widgets/movie_carousel/movie_title.dart';
import 'package:movies/view/widgets/seperator.dart';

import '../movies_app_bar.dart';
import './movie_page_view.dart';

class MovieCarousel extends StatelessWidget {
  const MovieCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        MovieBackdrop(),
        Column(
          children: [
            const MoviesAppBar(),
            const MoviePageView(),
            MovieTitle(),
            const Seperator(),
          ],
        ),
      ],
    );
  }
}
