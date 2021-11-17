import 'package:cinexa/components/content_category_view.dart';
import 'package:cinexa/models/movies/movie_category.dart';
import 'package:flutter/material.dart';

class MovieView extends StatelessWidget {
  const MovieView({
    Key? key,
    this.popularMovies,
    this.topRatedMovies,
    this.upcomingMovies,
    this.nowPlayingMovies,
  }) : super(key: key);

  final Future<List<MovieCategory>>? popularMovies;
  final Future<List<MovieCategory>>? topRatedMovies;
  final Future<List<MovieCategory>>? upcomingMovies;
  final Future<List<MovieCategory>>? nowPlayingMovies;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ContentCategoryView(
            contentToShow: popularMovies!,
            categoryText: "Popular",
            passedCategoryforData: "movie",
          ),
          SizedBox(height: 10),
          ContentCategoryView(
            contentToShow: topRatedMovies!,
            categoryText: "Top Rated",
            passedCategoryforData: "movie",
          ),
          SizedBox(height: 10),
          ContentCategoryView(
            contentToShow: upcomingMovies!,
            categoryText: "Upcoming",
            passedCategoryforData: "movie",
          ),
          SizedBox(height: 10),
          ContentCategoryView(
            contentToShow: nowPlayingMovies!,
            categoryText: "Now Playing",
            passedCategoryforData: "movie",
          ),
        ],
      ),
    );
  }
}
