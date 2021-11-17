import 'package:cinexa/components/content_tile.dart';
import 'package:cinexa/config/movie_cart.dart';
import 'package:cinexa/config/tvshow_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavlistScreen extends StatefulWidget {
  static const routeName = "/favlist_screen";
  const FavlistScreen({Key? key}) : super(key: key);

  @override
  _FavlistScreenState createState() => _FavlistScreenState();
}

class _FavlistScreenState extends State<FavlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<MovieCart, TvShowCart>(
      builder: (context, movieCart, tvShowCart, child) {
        if (movieCart.movies.length == 0 && tvShowCart.tvShows.length == 0) {
          return Center(
            child: Text("No movies bookmarked yet"),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(12),
              child: Text(
                "Movies",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(child: listViewMovies(movieCart)),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.all(12),
              child: Text(
                "TV Shows",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(child: listViewTvShows(tvShowCart)),
            SizedBox(height: 18),
          ],
        );
      },
    );
  }

  ListView listViewMovies(MovieCart movieContainer) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movieContainer.movies.length,
      itemBuilder: (context, index) {
        return Container(
          child: ContentTile(
            id: movieContainer.movies[index].id,
            posterPath: movieContainer.movies[index].posterPath!,
            passedCategoryforData: 'movie',
          ),
        );
      },
    );
  }

  ListView listViewTvShows(TvShowCart tvShowContainer) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: tvShowContainer.tvShows.length,
      itemBuilder: (context, index) {
        return Container(
          child: ContentTile(
            id: tvShowContainer.tvShows[index].id!,
            posterPath: tvShowContainer.tvShows[index].posterPath!,
            passedCategoryforData: 'tvshow',
          ),
        );
      },
    );
  }
}
