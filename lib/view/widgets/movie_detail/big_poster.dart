import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/constant/app_size.dart';
import 'package:movies/constant/app_text_theme.dart';
import 'package:movies/extension/size_extension.dart';
import 'package:movies/model/fav.dart';
import 'package:movies/model/movie_detail.dart';
import 'package:movies/util/screen_util.dart';
import 'package:movies/view/widgets/movie_detail/movie_detail_app_bar.dart';

import '../../../app_url.dart' as app_url;

class BigPoster extends StatelessWidget {
  final MovieDetail? movieDetail;

  const BigPoster({Key? key, @required this.movieDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.3),
                Theme.of(context).primaryColor,
              ],
            ),
          ),
          child: movieDetail != null
              ? movieDetail!.posterPath != null
                  ? CachedNetworkImage(
                      imageUrl:
                          '${app_url.baseImageUrl}${movieDetail!.posterPath}',
                      width: ScreenUtil.screenWidth,
                    )
                  : const SizedBox.shrink()
              : const SizedBox.shrink(),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: ListTile(
            title: Text(
              movieDetail!.title ?? '',
              style: Theme.of(context).textTheme.headline5,
            ),
            subtitle: Text(
              movieDetail!.releaseDate ?? '',
              style: Theme.of(context).textTheme.greySubtitle1,
            ),
            trailing: Text(
              movieDetail!.voteAverage.toString(),
              style: Theme.of(context).textTheme.violetHeadline6,
            ),
          ),
        ),
        Positioned(
          left: Sizes.dimen_16.w,
          right: Sizes.dimen_16.w,
          top: ScreenUtil.statusBarHeight + Sizes.dimen_4.h,
          child: MovieDetailAppBar(
              favourite: Fav(
                  id: movieDetail!.id,
                  posterPath: movieDetail!.posterPath,
                  title: movieDetail!.title)),
        ),
      ],
    );
  }
}
