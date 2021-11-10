import 'dart:developer';
import 'package:cinexa/models/movies/movie_types.dart';
import 'package:cinexa/service/http_service.dart';
import 'package:logging/logging.dart';

final _log = Logger('movie');

Future<List<PopularMovie>> fetchPopularMovies() async {
  _log.fine("fetching trending movies");
  final String apiKey = "107770dd1fa37c2b49e4efabdd273506";
  final params = {"api_key": apiKey};
  Map<String, dynamic> data = await (getJSON("movie/popular", params));
  // log(data.toString());
  List<PopularMovie> popularMovies = List<PopularMovie>.from(
      data["results"].map((x) => PopularMovie.fromJson(x)));
  return popularMovies;
}

Future<List<dynamic>> fetchMovieImages() async {
  _log.fine("fetching trending movies");
  final String apiKey = "107770dd1fa37c2b49e4efabdd273506";
  final params = {"api_key": apiKey};
  Map<String, dynamic> data =
      await (getImages("/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg", params));
  // log(data.toString());
  List<PopularMovie> popularMovies = List<PopularMovie>.from(
      data["results"].map((x) => PopularMovie.fromJson(x)));
  return popularMovies;
}
