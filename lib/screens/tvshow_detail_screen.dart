import 'package:cinexa/components/like_button.dart';
import 'package:cinexa/constants.dart';
import 'package:cinexa/models/tvshows/tvshow.dart';
import 'package:cinexa/service/fetch_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TvShowDetailScreen extends StatefulWidget {
  static final String routeName = "/moviedetailscreen";
  final int? id;
  final String? passedCategoryforData;
  const TvShowDetailScreen({Key? key, this.id, this.passedCategoryforData})
      : super(key: key);

  @override
  State<TvShowDetailScreen> createState() => _TvShowDetailScreenState();
}

class _TvShowDetailScreenState extends State<TvShowDetailScreen> {
  Future<TvShow>? tvshowwithid;
  FetchData? _fetchMovies = FetchData();

  @override
  void initState() {
    tvshowwithid = _fetchMovies!.fetchTvShowDetailsWithID(widget.id!);
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
                child: FutureBuilder<TvShow>(
                  future: tvshowwithid,
                  builder: (context, snapshot) {
                    TvShow? tvShow = snapshot.data;
                    if (snapshot.hasData) {
                      DateTime date = tvShow!.firstAirDate!.toLocal();
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
                                      tvShow.backdropPath!,
                                ),
                              ),
                              Spacer(),
                              Container(
                                margin: EdgeInsets.all(kDefaultTextPadding),
                                child: Text(
                                  tvShow.name.toString(),
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
                                      Text(tvShow.episodeRunTime.toString() +
                                          "min"),
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
                                  Text(
                                    "Average Rating",
                                    style:
                                        Theme.of(context).textTheme.subtitle1!,
                                  ),
                                  Text(
                                    tvShow.voteAverage.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          color: kPrimaryColor,
                                        ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.all(kDefaultTextPadding),
                                child: Text(
                                  tvShow.overview.toString(),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.subtitle1!,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Budget: ${tvShow.type.toString()}",
                              ),
                              Spacer(),
                            ],
                          ),
                          Positioned(
                            right: 0,
                            child: LikeButton(
                              tvShow: tvShow,
                              passedCategory: "tvshow",
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return Center(
                      child: const CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
