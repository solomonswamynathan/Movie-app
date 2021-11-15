import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/constant/app_color.dart';
import 'package:movies/constant/app_size.dart';
import 'package:movies/constant/app_text_theme.dart';
import 'package:movies/controller/movies_controller.dart';
import 'package:movies/extension/size_extension.dart';
import 'package:movies/view/widgets/search_movie/search_movie_card.dart';

class SearchMovies extends SearchDelegate {
  final MoviesController _moviesController = Get.find();

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
      hintStyle: Theme.of(context).textTheme.greySubtitle1,
    ));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: query.isEmpty ? Colors.grey : AppColor.royalBlue,
        ),
        onPressed: query.isEmpty ? null : () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () {
        close(context, null);
      },
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
        size: Sizes.dimen_12.h,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _moviesController.setQueryData(query);
    return Obx(
      () => _moviesController.searchResults!.results == null
          ? const SizedBox.shrink()
          : _moviesController.searchResults!.results!.isEmpty
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_64.w),
                    child: const Text(
                      'Movie not found',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return SearchMovieCard(
                      movie: _moviesController.searchResults!.results![index],
                    );
                  },
                  itemCount: _moviesController.searchResults!.results!.length,
                  scrollDirection: Axis.vertical,
                ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}
