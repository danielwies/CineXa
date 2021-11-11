import 'package:cinexa/constants.dart';
import 'package:cinexa/screens/movie_detail_screen.dart';
import 'package:flutter/material.dart';

class MovieTile extends StatelessWidget {
  final String movieTitle;
  final String urlToImg;

  const MovieTile({Key? key, required this.movieTitle, required this.urlToImg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, MovieDetailScreen.routeName);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            "https://image.tmdb.org/t/p/w500/" + urlToImg,
          ),
        ),
      ),
    );
  }
}
