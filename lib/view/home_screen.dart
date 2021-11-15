import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controller/db_controller.dart';

import 'package:movies/controller/movies_controller.dart';

import './widgets/movie_carousel/movie_carousel.dart';
import './navigation_drawer.dart';
import 'widgets/movie_tabbed/movie_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MoviesController _moviesController = Get.put(MoviesController());

  // ignore: unused_field
  final DBController _dbController = Get.put(DBController());

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  Future<void> getMovies() async {
    await _moviesController.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: const [
          FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: 0.6,
              child: MovieCarousel()),
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.4,
            child: MovieTab(),
          ),
        ],
      ),
    );
  }
}
