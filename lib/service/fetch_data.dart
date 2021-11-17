import 'dart:developer';
import 'package:cinexa/models/movies/movie.dart';
import 'package:cinexa/models/movies/movie_category.dart';
import 'package:cinexa/models/tvshows/tvshow.dart';
import 'package:cinexa/models/tvshows/tvshow_category.dart';
import 'package:cinexa/service/http_service.dart';

class FetchData {
  String? urlPath;

  FetchData({this.urlPath});

  Future<List<MovieCategory>> fetchMoviesOfCategory(String urlPath) async {
    final String apiKey = "107770dd1fa37c2b49e4efabdd273506";
    final params = {"api_key": apiKey};
    Map<String, dynamic> data = await (getJSON("movie/$urlPath", params));
    List<MovieCategory> moviesOfCategory = List<MovieCategory>.from(
        data["results"].map((x) => MovieCategory.fromJson(x)));
    return moviesOfCategory;
  }

  Future<List<TvShowCategory>> fetchTvShowsOfCategory(String urlPath) async {
    final String apiKey = "107770dd1fa37c2b49e4efabdd273506";
    final params = {"api_key": apiKey};
    Map<String, dynamic> data = await (getJSON("tv/$urlPath", params));
    List<TvShowCategory> tvShowsOfCategory = List<TvShowCategory>.from(
        data["results"].map((x) => TvShowCategory.fromJson(x)));
    return tvShowsOfCategory;
  }

  Future<Movie> fetchMovieDetailsWithID(int id) async {
    final String apiKey = "107770dd1fa37c2b49e4efabdd273506";
    final params = {"api_key": apiKey};
    Map<String, dynamic> data = await (getJSON("movie/$id", params));
    log(data.toString());
    final movie = Movie.fromJson(data);
    return movie;
  }

  Future<TvShow> fetchTvShowDetailsWithID(int id) async {
    final String apiKey = "107770dd1fa37c2b49e4efabdd273506";
    final params = {"api_key": apiKey};
    Map<String, dynamic> data = await (getJSON("tv/$id", params));
    log(data.toString());
    final tvShow = TvShow.fromJson(data);
    return tvShow;
  }
}
