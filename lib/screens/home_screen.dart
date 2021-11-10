import 'package:cinexa/components/header_tile.dart';
import 'package:cinexa/components/movie_tile.dart';
import 'package:cinexa/service/fetch_movies.dart';
import 'package:cinexa/models/movies/movie.dart';
import 'package:cinexa/models/movies/movie_types.dart';
import 'package:cinexa/service/http_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<PopularMovie>> popularMovies;
  late Future<List<dynamic>> getImages;

  @override
  void initState() {
    popularMovies = fetchPopularMovies();
    getImages = fetchMovieImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(Icons.movie),
            SizedBox(width: 10),
            Text("Movies"),
          ],
        ),
        backgroundColor: Colors.black,
        // shadowColor: Colors.grey,
      ),
      body: Column(
        children: [
          HeaderTile(leadingText: "Popular", trailingText: "See all"),
          Expanded(
            child: FutureBuilder(
              future: popularMovies,
              builder: (context, AsyncSnapshot<List<PopularMovie>> snapshot) {
                if (snapshot.hasData) {
                  print("has data");
                  return ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      PopularMovie popularMovie = snapshot.data![index];

                      return Column(
                        children: [
                          // Image.network(popularMovie.posterPath.toString()),
                          Text(
                            popularMovie.title.toString(),
                          ),
                          Text(
                            popularMovie.voteCount.toString(),
                          ),
                        ],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          )
        ],
      ),
    );
  }
}
