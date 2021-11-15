import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/constant/app_size.dart';
import 'package:movies/controller/movies_controller.dart';
import 'package:movies/extension/size_extension.dart';
import 'package:movies/extension/string_extension.dart';

import '../../../app_url.dart' as app_url;
import '../../movie_detail_screen.dart';

class MovieTabCard extends StatelessWidget {
  final int? movieId;
  final String? title;
  final String? posterPath;

  MovieTabCard(
      {Key? key,
      @required this.movieId,
      @required this.title,
      @required this.posterPath})
      : super(key: key);

  final MoviesController _moviesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _moviesController.setSelectedMovie(movieId: movieId);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const MovieDetailScreen()));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
              child: CachedNetworkImage(
                imageUrl: '${app_url.baseImageUrl}$posterPath',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Sizes.dimen_4.h),
            child: Text(
              '$title'.intelliTrim(),
              maxLines: 1,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}
