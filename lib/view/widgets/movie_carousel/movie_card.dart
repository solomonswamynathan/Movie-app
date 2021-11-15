import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/constant/app_size.dart';
import 'package:movies/controller/movies_controller.dart';
import 'package:movies/extension/size_extension.dart';
import 'package:movies/view/movie_detail_screen.dart';

import '../../../app_url.dart' as app_url;

class MovieCard extends StatelessWidget {
  final int? movieId;
  final String? posterPath;

  MovieCard({Key? key, @required this.movieId, @required this.posterPath})
      : super(key: key);

  final MoviesController _moviesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 32,
      borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
      child: GestureDetector(
        onTap: () async {
          await _moviesController.setSelectedMovie(movieId: movieId);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const MovieDetailScreen()));
        },
        child: posterPath != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
                child: CachedNetworkImage(
                  imageUrl: '${app_url.baseImageUrl}$posterPath',
                  fit: BoxFit.cover,
                ))
            : const SizedBox.shrink(),
      ),
    );
  }
}
