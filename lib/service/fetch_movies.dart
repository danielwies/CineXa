import 'dart:developer';

import 'package:cinexa/models/movies/movie.dart';
import 'package:cinexa/models/movies/movie_category.dart';
import 'package:cinexa/service/http_service.dart';

class FetchMovies {
  String? urlPath;

  FetchMovies({this.urlPath});

  Future<List<MovieCategory>> fetchMoviesOfCategory(String urlPath) async {
    final String apiKey = "107770dd1fa37c2b49e4efabdd273506";
    final params = {"api_key": apiKey};
    Map<String, dynamic> data = await (getJSON("movie/$urlPath", params));
    print("fetching Movies...");
    List<MovieCategory> topRatedMovies = List<MovieCategory>.from(
        data["results"].map((x) => MovieCategory.fromJson(x)));
    return topRatedMovies;
  }

  Future<Movie> fetchMovieDetailsWithID(int id) async {
    final String apiKey = "107770dd1fa37c2b49e4efabdd273506";
    final params = {"api_key": apiKey};
    Map<String, dynamic> data = await (getJSON("movie/$id", params));
    print("fetching Movie Details...");
    log(data.toString());
    final movie = Movie.fromJson(data);
    return movie;
  }
}
