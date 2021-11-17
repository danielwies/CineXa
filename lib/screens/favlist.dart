import 'package:cinexa/components/content_tile.dart';
import 'package:cinexa/config/movie_cart.dart';
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
    return Consumer<MovieCart>(
      builder: (context, container, child) {
        if (container.movies.length == 0) {
          return Center(
            child: Text("No movies bookmarked yet"),
          );
        }
        return Column(
          children: [
            Text("Movies"),
            Expanded(child: listView(container)),
            SizedBox(height: 50),
            Text("TV Shows"),
            Expanded(child: listView(container)),
          ],
        );
      },
    );
  }

  ListView listView(MovieCart movieContainer) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movieContainer.movies.length,
      itemBuilder: (context, index) {
        return Container(
          child: ContentTile(
            id: movieContainer.movies[index].id,
            posterPath: movieContainer.movies[index].posterPath!,
            passedCategoryforData: '',
          ),
        );
      },
    );
  }
}
