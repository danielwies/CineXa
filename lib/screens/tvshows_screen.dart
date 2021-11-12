import 'package:cinexa/components/content_category_view.dart';
import 'package:cinexa/models/tvshows/tvshow_category.dart';
import 'package:cinexa/service/fetch_data.dart';
import 'package:flutter/material.dart';

class TvShowsScreen extends StatefulWidget {
  const TvShowsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TvShowsScreen> createState() => _TvShowsScreenState();
}

class _TvShowsScreenState extends State<TvShowsScreen> {
  late Future<List<TvShowCategory>> popularTvShows;
  late Future<List<TvShowCategory>> topRatedTvShows;
  late Future<List<TvShowCategory>> airingTodayTvShows;
  late Future<List<TvShowCategory>> onAirTvShows;
  FetchData? _fetchMovies = FetchData();

  @override
  void initState() {
    popularTvShows = _fetchMovies!.fetchTvShowsOfCategory("popular");
    topRatedTvShows = _fetchMovies!.fetchTvShowsOfCategory("top_rated");
    airingTodayTvShows = _fetchMovies!.fetchTvShowsOfCategory("on_the_air");
    onAirTvShows = _fetchMovies!.fetchTvShowsOfCategory("airing_today");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ContentCategoryView(
                contentToShow: popularTvShows, category: "Popular"),
            SizedBox(height: 10),
            ContentCategoryView(
                contentToShow: topRatedTvShows, category: "Top Rated"),
            SizedBox(height: 10),
            ContentCategoryView(
                contentToShow: airingTodayTvShows, category: "Airing Today"),
            SizedBox(height: 10),
            ContentCategoryView(
                contentToShow: onAirTvShows, category: "On Air"),
          ],
        ),
      ),
    );
  }
}
