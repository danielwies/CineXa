import 'package:cinexa/components/selected_movie_view.dart';
import 'package:cinexa/constants.dart';
import 'package:cinexa/design/theme_switch.dart';
import 'package:cinexa/models/movies/popular_movies.dart';
import 'package:cinexa/models/movies/top_rated_movies.dart';
import 'package:cinexa/models/movies/upcoming_movies.dart';
import 'package:cinexa/service/fetch_movies.dart';
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
  late Future<List<TopRatedMovie>> topRatedMovies;
  late Future<List<UpcomingMovie>> upcomingMovies;

  bool _darkTheme = true;
  int _selectedIndex = 0;

  @override
  void initState() {
    popularMovies = fetchPopularMovies();
    topRatedMovies = fetchTopRatedMovies();
    upcomingMovies = fetchUpcomingMovies();
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
        shadowColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MovieView(moviesToShow: popularMovies, category: "Popular"),
            SizedBox(height: 10),
            MovieView(moviesToShow: topRatedMovies, category: "Top Rated"),
            SizedBox(height: 10),
            MovieView(moviesToShow: upcomingMovies, category: "Upcoming"),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'TV Shows',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        onTap: _onItemTapped,
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void toggleSelect(bool selectValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      selectValue
          ? prefs.setBool("darkTheme", false)
          : prefs.setBool("darkTheme", true);
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
