import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/constant/app_size.dart';
import 'package:movies/constant/movie_tab_constant.dart';
import 'package:movies/controller/movies_controller.dart';
import 'package:movies/extension/size_extension.dart';
import 'package:movies/view/widgets/movie_tabbed/movie_list_view.dart';
import 'package:movies/view/widgets/movie_tabbed/tab_title.dart';

class MovieTab extends StatefulWidget {
  const MovieTab({Key? key}) : super(key: key);

  @override
  _MovieTabState createState() => _MovieTabState();
}

class _MovieTabState extends State<MovieTab> {
  final MoviesController _moviesController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Sizes.dimen_4.h),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var i = 0; i < MovieTabbedConstants.movieTabs.length; i++)
                Obx(
                  () => TabTitle(
                    title: MovieTabbedConstants.movieTabs[i].title,
                    onTap: () async {
                      await _moviesController.setSelectedTab(i);
                    },
                    // isSelected: true,
                    isSelected: i == _moviesController.selectedTab,
                  ),
                )
            ],
          ),
          Obx(
            () {
              return _moviesController.movieListAsPerTab().isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text(
                          'No Movies Found',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    )
                  : Expanded(
                      child: MovieListView(
                        movies: _moviesController.movieListAsPerTab(),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
