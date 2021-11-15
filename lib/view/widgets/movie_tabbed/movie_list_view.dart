import 'package:flutter/material.dart';
import 'package:movies/constant/app_size.dart';
import 'package:movies/extension/size_extension.dart';
import 'package:movies/model/movies.dart';
import 'package:movies/view/widgets/movie_tabbed/movie_tab_card.dart';

class MovieListView extends StatelessWidget {
  final List<Results>? movies;
  const MovieListView({Key? key, @required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Sizes.dimen_6.h),
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: movies!.length,
        separatorBuilder: (context, index) {
          return SizedBox(
            width: Sizes.dimen_14.w,
          );
        },
        itemBuilder: (context, index) {
          Results movie = movies![index];
          return MovieTabCard(
            movieId: movie.id,
            title: movie.title,
            posterPath: movie.posterPath,
          );
        },
      ),
    );
  }
}
