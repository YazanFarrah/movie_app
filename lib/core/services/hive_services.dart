import 'dart:developer';

import 'package:get/get.dart';
import 'package:movie_app/config/hive_box_constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';
import 'package:movie_app/features/home/data/models/tv_series_model.dart';

class HiveServices {
  final Box _box = Hive.box();

  void setLanguageCode(Locale lang) {
    _box.put(AppSettingsBoxConstants.languageKey, lang.languageCode);
  }

  String get getLanguage {
    return Get.locale?.languageCode ?? "ar";
  }

  // Token management
  void setToken(String? token) {
    if (token != null) {
      log("Setting token");
      _box.put(AppSettingsBoxConstants.tokenKey, token);
    }
  }

  String? get getToken {
    log("fetching token");
    return _box.get(AppSettingsBoxConstants.tokenKey) as String?;
  }

  // Theme management
  void setThemeMode(bool isDarkMode) {
    _box.put(AppSettingsBoxConstants.themeModeKey, isDarkMode);
  }

  bool? getThemeMode() {
    return _box.get(AppSettingsBoxConstants.themeModeKey) as bool?;
  }

  // App rating management

  void setAppRated() {
    _box.put(AppSettingsBoxConstants.isAppRatedKey, true);
  }

  bool? getIsAppRated() {
    return _box.get(AppSettingsBoxConstants.isAppRatedKey) as bool?;
  }

  void setTotalTimeSpent(int seconds) {
    _box.put(AppSettingsBoxConstants.totalTimeSpentKey, seconds);
  }

  int getTotalTimeSpent() {
    return _box.get(AppSettingsBoxConstants.totalTimeSpentKey, defaultValue: 0)
        as int;
  }

  Future<void> clearPreferences() async {
    _box.clear();
  }

// user services:

  void saveUserData(UserModel user) {
    _box.put("userJson", user.toJson());
  }

  UserModel? fetchUserData() {
    return _box.get("userJson") as UserModel;
  }

  // Movies
  void saveMovieLocally(Movie movie) {
    final key = "movie_${movie.id}";
    if (!_box.containsKey(key)) {
      _box.put(key, movie.toJson());
      log("Movie saved with key: $key");
    }
  }

  void removeMovieLocally(Movie movie) {
    final key = "movie_${movie.id}";
    if (_box.containsKey(key)) {
      _box.delete(key);
      log("Movie removed with key: $key");
    }
  }

  List<Movie> fetchSavedMovies() {
    List<Movie> movies = [];
    for (var key in _box.keys) {
      if (key.toString().startsWith("movie_")) {
        final json = _box.get(key);
        movies.add(Movie.fromJson(json));
      }
    }
    return movies;
  }

  // TV Series
  void saveTvSeriesLocally(TvSeriesModel tvSeries) {
    final key = "tvSeries_${tvSeries.id}";
    if (!_box.containsKey(key)) {
      _box.put(key, tvSeries.toJson());
      log("TV series saved with key: $key");
    }
  }

  void removeTvSeriesLocally(TvSeriesModel tvSeries) {
    final key = "tvSeries_${tvSeries.id}";
    if (_box.containsKey(key)) {
      _box.delete(key);
      log("TV series removed with key: $key");
    }
  }

  List<TvSeriesModel> fetchSavedTvSeries() {
    List<TvSeriesModel> tvSeriesList = [];
    for (var key in _box.keys) {
      if (key.toString().startsWith("tvSeries_")) {
        final json = _box.get(key);
        tvSeriesList.add(TvSeriesModel.fromJson(json));
      }
    }
    return tvSeriesList;
  }
}
