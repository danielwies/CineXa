import 'dart:collection';
import 'dart:convert';
import 'package:cinexa/models/tvshows/tvshow.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _log = Logger("MovieCart");

class TvShowCart extends ChangeNotifier {
  final List<TvShow> _tvShows = [];
  UnmodifiableListView<TvShow> get tvShows => UnmodifiableListView(_tvShows);

  static const SAVED_TVSHOWS_KEY = "tvShow_cart";
  late SharedPreferences prefs;

  TvShowCart() {
    loadState();
  }

  loadState() async {
    prefs = await SharedPreferences.getInstance();
    _loadTvShows();
  }

  _loadTvShows() {
    final settingString = prefs.getString(SAVED_TVSHOWS_KEY);

    if (settingString == null) {
      return null;
    }

    _log.fine("Loading tvShowCart from SharedPrefs: $settingString");

    var settingsJSON = json.decode(settingString);

    settingsJSON.forEach((element) {
      final tvShow = TvShow.fromJson(element);
      _log.fine("loading: ${tvShow.name}");
      _tvShows.add(tvShow);
    });
  }

  void save() {
    var _payload = json.encode(_tvShows.map((e) => e.toJson()).toList());
    print(_payload);
    prefs.setString(SAVED_TVSHOWS_KEY, _payload);
  }

  void add(TvShow tvShow) {
    print("Adding TvShow to Cart ${tvShow.name}");
    _tvShows.add(tvShow);
    save();
    notifyListeners();
  }

  void remove(TvShow tvShow) {
    print("Removing TvShow from Cart ${tvShow.name}");
    _tvShows.removeWhere((element) => element.id == tvShow.id);
    save();
    notifyListeners();
  }

  bool isLiked(TvShow? tvShow) {
    return _tvShows.any((element) => element.id == tvShow!.id);
  }
}
