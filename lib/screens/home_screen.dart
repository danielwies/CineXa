import 'package:cinexa/components/header_tile.dart';
import 'package:cinexa/components/movie_tile.dart';
import 'package:cinexa/design/theme_switch.dart';
import 'package:cinexa/service/fetch_movies.dart';
import 'package:cinexa/models/movies/movie_types.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<PopularMovie>> popularMovies;
  bool _darkTheme = true;

  @override
  void initState() {
    popularMovies = fetchPopularMovies();
    checkIfDarkmodeEnabled();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(),
        automaticallyImplyLeading: false,
        title: appBarWidget(context),
        shadowColor: Colors.grey,
      ),
      body: Column(
        children: [
          HeaderTile(leadingText: "Popular", trailingText: "See all"),
          Container(
            height: 270,
            child: FutureBuilder(
              future: popularMovies,
              builder: (context, AsyncSnapshot<List<PopularMovie>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      PopularMovie popularMovie = snapshot.data![index];
                      return MovieTile(
                        movieTitle: popularMovie.title!,
                        urlToImg: popularMovie.posterPath!,
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Center(child: const CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    );
  }

  Row appBarWidget(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.movie),
        SizedBox(width: 10),
        Text(
          "Movies",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Spacer(flex: 8),
        Expanded(
          child: IconButton(
            icon: _darkTheme ? Icon(Icons.dark_mode) : Icon(Icons.light_mode),
            onPressed: () {
              toggleSelect(_darkTheme);
              _darkTheme = !_darkTheme;
            },
          ),
        ),
      ],
    );
  }

  void toggleSelect(bool selectValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      selectValue
          ? prefs.setBool("darkTheme", false)
          : prefs.setBool("darkTheme", true);
      print("DARKMODE ENABLED: $_darkTheme");

      Provider.of<ThemeSwitchProvider>(context, listen: false).swapTheme();
    });
  }

  checkIfDarkmodeEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.getBool("darkTheme") == true
          ? _darkTheme = true
          : _darkTheme = false;
    });
  }
}
