import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/constant/app_size.dart';
import 'package:movies/constant/app_text_theme.dart';
import 'package:movies/extension/size_extension.dart';
import 'package:movies/model/movie_cast.dart';

import '../../../app_url.dart' as app_url;

class MovieCastCard extends StatelessWidget {
  final MovieCast? movieCast;
  const MovieCastCard({Key? key, @required this.movieCast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Sizes.dimen_100.h,
        child: movieCast!.cast != null
            ? ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: movieCast!.cast!.length,
                itemBuilder: (context, index) {
                  Cast cast = movieCast!.cast![index];
                  return SizedBox(
                    height: Sizes.dimen_100.h,
                    width: Sizes.dimen_160.w,
                    child: Card(
                      elevation: 1,
                      margin: EdgeInsets.symmetric(
                        horizontal: Sizes.dimen_8.w,
                        vertical: Sizes.dimen_4.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(Sizes.dimen_8.w),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(Sizes.dimen_8.w),
                              ),
                              child: cast.profilePath != null
                                  ? CachedNetworkImage(
                                      height: Sizes.dimen_100.h,
                                      width: Sizes.dimen_160.w,
                                      imageUrl:
                                          '${app_url.baseImageUrl}${cast.profilePath}',
                                      fit: BoxFit.fitWidth,
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Sizes.dimen_8.w,
                            ),
                            child: Text(
                              cast.name!,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.whiteBodyText2,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: Sizes.dimen_8.w,
                              right: Sizes.dimen_8.w,
                              bottom: Sizes.dimen_2.h,
                            ),
                            child: Text(
                              cast.character!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const SizedBox.shrink());
  }
}
