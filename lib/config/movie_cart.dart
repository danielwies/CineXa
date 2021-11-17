import 'dart:collection';
import 'dart:convert';
import 'package:cinexa/models/movies/movie.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _log = Logger("MovieCart");

class MovieCart extends ChangeNotifier {
  final List<Movie> _movies = [];
  UnmodifiableListView<Movie> get movies => UnmodifiableListView(_movies);

  static const SAVED_MOVIES_KEY = "movie_cart";
  late SharedPreferences prefs;

  MovieCart() {
    loadState();
  }

  loadState() async {
    prefs = await SharedPreferences.getInstance();
    _loadMovies();
  }

  _loadMovies() {
    final settingString = prefs.getString(SAVED_MOVIES_KEY);

    if (settingString == null) {
      return null;
    }

    _log.fine("Loading movieCart from SharedPrefs: $settingString");

    var settingsJSON = json.decode(settingString);

    settingsJSON.forEach((element) {
      final movie = Movie.fromJson(element);
      _log.fine("loading: ${movie.title}");
      _movies.add(movie);
    });
  }

  void save() {
    var _payload = json.encode(_movies.map((e) => e.toJson()).toList());
    print(_payload);
    prefs.setString(SAVED_MOVIES_KEY, _payload);
  }

  void add(Movie movie) {
    print("Adding Movie to Cart ${movie.title}");
    _movies.add(movie);
    save();
    notifyListeners();
  }

  void remove(Movie movie) {
    print("Removing Movie from Cart ${movie.title}");
    _movies.removeWhere((element) => element.id == movie.id);
    save();
    notifyListeners();
  }

  bool isLiked(Movie? movie) {
    return _movies.any((element) => element.id == movie!.id);
  }
}
