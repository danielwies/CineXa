import 'package:cinexa/components/like_button.dart';
import 'package:cinexa/constants.dart';
import 'package:cinexa/models/movies/movie.dart';
import 'package:cinexa/models/tvshows/tvshow.dart';
import 'package:cinexa/service/fetch_data.dart';
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
  FetchData? _fetchMovies = FetchData();

  @override
  void initState() {
    moviewithid = _fetchMovies!.fetchMovieDetailsWithID(widget.id!);
    print(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconTheme.of(context).copyWith(),
        title: Text(
          "Details",
          style: Theme.of(context).textTheme.headline6,
        ),
        shadowColor: Colors.transparent,
      ),
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                  child: FutureBuilder<Movie>(
                future: moviewithid,
                builder: (context, snapshot) {
                  Movie? movie = snapshot.data;
                  if (snapshot.hasData) {
                    DateTime date = movie!.releaseDate!.toLocal();
                    String convertedDateDE =
                        DateFormat('dd-MM-yyyy').format(date);
                    return Stack(
                      children: [
                        Column(
                          children: [
                            ShaderMask(
                              shaderCallback: (rect) {
                                return LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.black, Colors.transparent],
                                ).createShader(Rect.fromLTRB(
                                    0, 80, rect.width, rect.height));
                              },
                              blendMode: BlendMode.dstIn,
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w500/" +
                                    movie.backdropPath!,
                              ),
                            ),
                            Spacer(),
                            Container(
                              margin: EdgeInsets.all(kDefaultTextPadding),
                              child: Text(
                                movie.title.toString(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(color: kPrimaryColor),
                              ),
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Spacer(),
                                    Text("Runtime:"),
                                    Spacer(),
                                    Text("Release-Date:"),
                                    Spacer(),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Spacer(),
                                    Text(movie.runtime.toString() + "min"),
                                    Spacer(),
                                    Text("   " + convertedDateDE),
                                    Spacer(),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Text("Average Rating",
                                    style:
                                        Theme.of(context).textTheme.subtitle1!),
                                Text(
                                  "test",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: kPrimaryColor),
                                ),
                              ],
                            ),
                            Container(
                                margin: EdgeInsets.all(kDefaultTextPadding),
                                child: Text(movie.overview.toString(),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!)),
                            Spacer(),
                            Text(
                              "Budget: ${movie.budget.toString()}",
                            ),
                            Spacer(),
                          ],
                        ),
                        Positioned(
                          right: 0,
                          child: LikeButton(movie: movie),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return Center(child: const CircularProgressIndicator());
                },
              )),
            ),
          );
        },
      ),
    );
  }
}
