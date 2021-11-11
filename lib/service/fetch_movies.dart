import 'dart:developer';
import 'package:cinexa/models/movies/popular_movies.dart';
import 'package:cinexa/models/movies/top_rated_movies.dart';
import 'package:cinexa/models/movies/upcoming_movies.dart';
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

Future<List<TopRatedMovie>> fetchTopRatedMovies() async {
  _log.fine("fetching trending movies");
  final String apiKey = "107770dd1fa37c2b49e4efabdd273506";
  final params = {"api_key": apiKey};
  Map<String, dynamic> data = await (getJSON("movie/top_rated", params));
  List<TopRatedMovie> topRatedMovies = List<TopRatedMovie>.from(
      data["results"].map((x) => TopRatedMovie.fromJson(x)));
  return topRatedMovies;
}

Future<List<UpcomingMovie>> fetchUpcomingMovies() async {
  _log.fine("fetching trending movies");
  final String apiKey = "107770dd1fa37c2b49e4efabdd273506";
  final params = {"api_key": apiKey};
  Map<String, dynamic> data = await (getJSON("movie/upcoming", params));
  // log(data.toString());
  List<UpcomingMovie> upcomingMovies = List<UpcomingMovie>.from(
      data["results"].map((x) => UpcomingMovie.fromJson(x)));
  return upcomingMovies;
}
