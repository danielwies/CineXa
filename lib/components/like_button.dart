import 'package:cinexa/config/movie_cart.dart';
import 'package:cinexa/models/movies/movie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({
    Key? key,
    required this.movie,
    this.size,
  }) : super(key: key);

  final Movie? movie;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieCart>(
      builder: (context, cart, child) => IconButton(
        key: Key("likeButton"),
        icon: Icon(
          (movie != null && cart.isLiked(movie))
              ? Icons.favorite
              : Icons.favorite_border,
          color: Colors.red,
          size: size,
        ),
        onPressed: () {
          if (cart.isLiked(movie)) {
            cart.remove(movie!);
          } else {
            cart.add(movie!);
          }
        },
      ),
    );
  }
}
