import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controller/db_controller.dart';
import 'package:movies/view/widgets/favourite/fav_grid_view.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  final DBController _dbController = Get.find();

  @override
  void initState() {
    super.initState();
    getFavMovies();
  }

  getFavMovies() async {
    await _dbController.getFavMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favourite Movies',
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: Colors.transparent,
      ),
      body: Obx(
        () {
          return _dbController.favMovies.isEmpty
              ? Center(
                  child: Text(
                    'No watch list added',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                )
              : FavGridView(
                  movies: _dbController.favMovies,
                );
        },
      ),
    );
  }
}
