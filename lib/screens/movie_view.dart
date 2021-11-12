import 'package:cinexa/components/movie_category_view.dart';
import 'package:cinexa/models/movies/movie_category.dart';
import 'package:flutter/material.dart';

class MovieViewScreen extends StatelessWidget {
  const MovieViewScreen({
    Key? key,
    required this.popularMovies,
    required this.topRatedMovies,
    required this.upcomingMovies,
    required this.nowPlayingMovies,
  }) : super(key: key);

  final Future<List<MovieCategory>> popularMovies;
  final Future<List<MovieCategory>> topRatedMovies;
  final Future<List<MovieCategory>> upcomingMovies;
  final Future<List<MovieCategory>> nowPlayingMovies;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          MovieCategoryView(moviesToShow: popularMovies, category: "Popular"),
          SizedBox(height: 10),
          MovieCategoryView(
              moviesToShow: topRatedMovies, category: "Top Rated"),
          SizedBox(height: 10),
          MovieCategoryView(moviesToShow: upcomingMovies, category: "Upcoming"),
          SizedBox(height: 10),
          MovieCategoryView(
              moviesToShow: nowPlayingMovies, category: "Now Playing"),
        ],
      ),
    );
  }
}
