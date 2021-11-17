import 'package:cinexa/config/movie_cart.dart';
import 'package:cinexa/config/tvshow_cart.dart';
import 'package:cinexa/models/movies/movie.dart';
import 'package:cinexa/models/tvshows/tvshow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({
    Key? key,
    this.movie,
    required this.passedCategory,
    this.size,
    this.tvShow,
  }) : super(key: key);

  final Movie? movie;
  final TvShow? tvShow;
  final double? size;
  final String? passedCategory;

  @override
  Widget build(BuildContext context) {
    return Consumer2<MovieCart, TvShowCart>(
      builder: (context, moviecart, tvshowcart, child) =>
          passedCategory == "movie"
              ? IconButton(
                  key: Key("likeButton"),
                  icon: Icon(
                    (movie != null && moviecart.isLiked(movie))
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
                    size: size,
                  ),
                  onPressed: () {
                    if (moviecart.isLiked(movie)) {
                      moviecart.remove(movie!);
                    } else {
                      moviecart.add(movie!);
                    }
                  },
                )
              : IconButton(
                  key: Key("likeButton"),
                  icon: Icon(
                    (tvShow != null && tvshowcart.isLiked(tvShow))
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
                    size: size,
                  ),
                  onPressed: () {
                    if (tvshowcart.isLiked(tvShow)) {
                      tvshowcart.remove(tvShow!);
                    } else {
                      tvshowcart.add(tvShow!);
                    }
                  },
                ),
    );
  }
}
