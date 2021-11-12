import 'package:cinexa/models/movies/movie.dart';
import 'package:cinexa/service/fetch_movies.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MovieDetailScreen extends StatefulWidget {
  static final String routeName = "/moviedetailscreen";
  final int? id;
  const MovieDetailScreen({Key? key, this.id}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  Future<Movie>? moviewithid;
  FetchMovies? _fetchMovies = FetchMovies();

  @override
  void initState() {
    moviewithid = _fetchMovies!.fetchMovieDetailsWithID(widget.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(),
        title: Text(
          "Details",
          style: Theme.of(context).textTheme.headline6,
        ),
        shadowColor: Colors.grey,
      ),
      body: Container(
        child: FutureBuilder<Movie>(
          future: moviewithid,
          builder: (context, snapshot) {
            Movie? movie = snapshot.data;
            if (snapshot.hasData) {
              DateTime date = movie!.releaseDate!.toLocal();
              String convertedDateDE = DateFormat('dd-MM-yyyy').format(date);
              return Container(
                child: Column(
                  children: [
                    Image.network("https://image.tmdb.org/t/p/w500/" +
                        movie.backdropPath!),
                    Text(movie.runtime.toString()),
                    Text(movie.title.toString()),
                    Text(convertedDateDE),
                    Text(movie.overview.toString()),
                    Text("Vote Average: ${movie.voteAverage.toString()}"),
                    Text("Vote Count: ${movie.voteCount.toString()}"),
                    Text("Budget: ${movie.budget.toString()}"),
                    // Row(
                    //     children: Genres.values
                    //         .map((e) => Text(e.toString()))
                    //         .toList()),
                    // Text(movie.productionCompanies.toString()),
                    // Text(movie.genres.toString()),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(child: const CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

// enum Genres { thriller, scifi }
