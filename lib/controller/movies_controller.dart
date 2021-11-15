import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:movies/model/movie_cast.dart';
import 'package:movies/model/movie_detail.dart';
import 'package:movies/model/movies.dart';

import '../services/base_client.dart';
import '../app_url.dart' as app_url;
import '../services/base_controller.dart';

class MoviesController extends GetxController with BaseController {
  final BaseClient _baseClient = BaseClient();

  // ignore: prefer_final_fields
  RxInt _selectedTab = 0.obs;

  int? get selectedTab => _selectedTab.value;

  setSelectedTab(int? index) async {
    _selectedTab.value = index!;
    if (selectedTab == 0 && popularMovies!.results == null) {
      await getPopularMovies();
    } else if (selectedTab == 1 && nowMovies!.results == null) {
      await getNowMovies();
    } else if (selectedTab == 2 && soonMovies!.results == null) {
      await getSoonMovies();
    }
  }

  List<Results> movieListAsPerTab() {
    if (selectedTab == 0) {
      return popularMovies!.results ?? [];
    } else if (selectedTab == 1) {
      return nowMovies!.results ?? [];
    } else if (selectedTab == 2) {
      return soonMovies!.results ?? [];
    }
    return popularMovies!.results ?? [];
  }

  // to change the backdrop image in homePage
  Rx<Results> currentMovieInDisplay = Results().obs;

// ignore: prefer_final_fields
  Rx<Movies> _movies = Movies().obs;
  Movies? get movies => _movies.value;

  getMovies() async {
    var headerObj = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    var response = await _baseClient
        .getRequest(
            api:
                'discover/movie?sort_by=popularity.desc&api_key=${app_url.apiKey}',
            headers: headerObj)
        .catchError(handleError);
    if (response == null) {
      return;
    } else {
      Movies responseData = Movies.fromJson(json.decode(response));
      _movies.value = responseData;
      await getPopularMovies();
    }
  }

  // ignore: prefer_final_fields
  Rx<Movies> _popularMovies = Movies().obs;
  Movies? get popularMovies => _popularMovies.value;

  getPopularMovies() async {
    var headerObj = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    var response = await _baseClient
        .getRequest(
            api: 'movie/popular?api_key=${app_url.apiKey}', headers: headerObj)
        .catchError(handleError);
    if (response == null) {
      return;
    } else {
      Movies responseData = Movies.fromJson(json.decode(response));
      _popularMovies.value = responseData;
    }
  }

  // ignore: prefer_final_fields
  Rx<Movies> _nowMovies = Movies().obs;
  Movies? get nowMovies => _nowMovies.value;

  getNowMovies() async {
    var headerObj = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    var response = await _baseClient
        .getRequest(
            api: 'movie/now_playing?api_key=${app_url.apiKey}',
            headers: headerObj)
        .catchError(handleError);
    if (response == null) {
      return;
    } else {
      Movies responseData = Movies.fromJson(json.decode(response));
      _nowMovies.value = responseData;
    }
  }

  // ignore: prefer_final_fields
  Rx<Movies> _soonMovies = Movies().obs;
  Movies? get soonMovies => _soonMovies.value;

  getSoonMovies() async {
    var headerObj = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    var response = await _baseClient
        .getRequest(
            api: 'movie/upcoming?api_key=${app_url.apiKey}', headers: headerObj)
        .catchError(handleError);
    if (response == null) {
      return;
    } else {
      Movies responseData = Movies.fromJson(json.decode(response));
      _soonMovies.value = responseData;
    }
  }

  // ignore: prefer_final_fields
  RxInt _selectedMovie = 0.obs;
  int get selectedMovie => _selectedMovie.value;

  setSelectedMovie({@required int? movieId}) async {
    _selectedMovie.value = movieId!;
  }

  // ignore: prefer_final_fields
  Rx<MovieDetail> _movieDetail = MovieDetail().obs;
  MovieDetail? get movieDetail => _movieDetail.value;

  getMovieDetail() async {
    var headerObj = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    var response = await _baseClient
        .getRequest(
            api:
                'movie/$selectedMovie?api_key=${app_url.apiKey}&language=en-US',
            headers: headerObj)
        .catchError(handleError);
    if (response == null) {
      return;
    } else {
      MovieDetail responseData = MovieDetail.fromJson(json.decode(response));
      _movieDetail.value = responseData;
    }
  }

  // ignore: prefer_final_fields
  Rx<MovieCast> _movieCast = MovieCast().obs;
  MovieCast? get movieCast => _movieCast.value;

  getMovieCast() async {
    var headerObj = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    var response = await _baseClient
        .getRequest(
            api:
                'movie/$selectedMovie/credits?api_key=${app_url.apiKey}&language=en-US',
            headers: headerObj)
        .catchError(handleError);
    if (response == null) {
      return;
    } else {
      MovieCast responseData = MovieCast.fromJson(json.decode(response));
      _movieCast.value = responseData;
    }
  }

// ignore: prefer_final_fields
  Rx<Movies> _searchResults = Movies().obs;
  Movies? get searchResults => _searchResults.value;
  String? queryData;

  setQueryData(String query) async {
    queryData = query;
    if (queryData != "") {
      await getsearchResults();
    }
  }

  getsearchResults() async {
    var headerObj = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    var response = await _baseClient
        .getRequest(
            api: 'search/movie?api_key=${app_url.apiKey}&query=$queryData',
            headers: headerObj)
        .catchError(handleError);
    if (response == null) {
      return;
    } else {
      Movies responseData = Movies.fromJson(json.decode(response));
      _searchResults.value = responseData;
    }
  }
}
