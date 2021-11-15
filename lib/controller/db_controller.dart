import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:movies/DB/db_helper.dart';
import 'package:movies/model/fav.dart';

class DBController extends GetxController {
  addMovieToFav({@required Fav? movie}) async {
    await DatabaseHelper.instance.addMovieToFav(movie!);
    await getFavMovies();
  }

  removeMovieFromFav({@required Fav? movie}) async {
    await DatabaseHelper.instance.removeMovieFromFav(movie!.id!);
    await getFavMovies();
  }

  // ignore: prefer_final_fields
  RxList<Fav> _favMovies = <Fav>[].obs;
  // ignore: invalid_use_of_protected_member
  List<Fav> get favMovies => _favMovies.value;

  getFavMovies() async {
    _favMovies.value = await DatabaseHelper.instance.getAllMovies();
  }
}
