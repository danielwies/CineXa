import 'package:cinexa/components/header_tile.dart';
import 'package:cinexa/components/movie_tile.dart';
import 'package:flutter/material.dart';

class MovieCategoryView extends StatelessWidget {
  const MovieCategoryView(
      {Key? key, required this.moviesToShow, required this.category})
      : super(key: key);

  final Future<List<dynamic>> moviesToShow;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderTile(leadingText: category, trailingText: "See all"),
        Container(
          height: 270,
          child: FutureBuilder(
            future: moviesToShow,
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    dynamic selectedMovieType = snapshot.data![index];
                    return MovieTile(
                      id: selectedMovieType.id,
                      posterPath: selectedMovieType.posterPath,
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return Center(child: const CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
