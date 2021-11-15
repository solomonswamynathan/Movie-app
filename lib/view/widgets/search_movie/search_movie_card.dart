import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/constant/app_size.dart';
import 'package:movies/constant/app_text_theme.dart';
import 'package:movies/controller/movies_controller.dart';
import 'package:movies/extension/size_extension.dart';
import 'package:movies/model/movies.dart';

import '../../../app_url.dart' as app_url;
import '../../movie_detail_screen.dart';

class SearchMovieCard extends StatelessWidget {
  final Results? movie;

  SearchMovieCard({Key? key, @required this.movie}) : super(key: key);

  final MoviesController _moviesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _moviesController.setSelectedMovie(movieId: movie!.id);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const MovieDetailScreen()));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.dimen_16.w,
          vertical: Sizes.dimen_2.h,
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(Sizes.dimen_8.w),
              child: movie!.posterPath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(Sizes.dimen_4.w),
                      child: CachedNetworkImage(
                        imageUrl: '${app_url.baseImageUrl}${movie!.posterPath}',
                        width: Sizes.dimen_80.w,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    movie!.title!,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    movie!.overview ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.greyCaption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
