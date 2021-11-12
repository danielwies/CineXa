import 'package:cinexa/screens/movie_detail_screen.dart';
import 'package:flutter/material.dart';

class MovieTile extends StatelessWidget {
  final String posterPath;
  final int id;

  const MovieTile({
    Key? key,
    required this.posterPath,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(
                id: id,
              ),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            "https://image.tmdb.org/t/p/w500/" + posterPath,
          ),
        ),
      ),
    );
  }
}
