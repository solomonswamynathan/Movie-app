import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/constant/app_size.dart';
import 'package:movies/controller/db_controller.dart';
import 'package:movies/controller/movies_controller.dart';
import 'package:movies/extension/size_extension.dart';
import 'package:movies/model/fav.dart';

import '../../../app_url.dart' as app_url;
import '../../movie_detail_screen.dart';

class FavMovieCard extends StatelessWidget {
  final Fav? movie;

  FavMovieCard({Key? key, @required this.movie}) : super(key: key);

  final MoviesController _moviesController = Get.find();
  final DBController _dbController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Sizes.dimen_8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.dimen_8.w),
      ),
      child: GestureDetector(
        onTap: () async {
          await _moviesController.setSelectedMovie(movieId: movie!.id);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const MovieDetailScreen()));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.dimen_8.w),
          child: Stack(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: '${app_url.baseImageUrl}${movie!.posterPath}',
                fit: BoxFit.cover,
                width: Sizes.dimen_100.h,
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    _dbController.removeMovieFromFav(movie: movie);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(Sizes.dimen_12.w),
                    child: Icon(
                      Icons.delete,
                      size: Sizes.dimen_12.h,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
