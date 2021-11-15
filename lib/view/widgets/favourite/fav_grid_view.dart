import 'package:flutter/material.dart';
import 'package:movies/constant/app_size.dart';
import 'package:movies/extension/size_extension.dart';
import 'package:movies/model/fav.dart';

import 'fav_movie_card.dart';

class FavGridView extends StatelessWidget {
  final List<Fav>? movies;
  const FavGridView({Key? key, @required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: movies!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: Sizes.dimen_16.w,
        ),
        itemBuilder: (context, index) {
          return FavMovieCard(
            movie: movies![index],
          );
        },
      ),
    );
  }
}
