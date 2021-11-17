import 'package:cinexa/constants.dart';
import 'package:cinexa/design/theme_switch.dart';
import 'package:cinexa/models/movies/movie.dart';
import 'package:cinexa/models/movies/movie_category.dart';
import 'package:cinexa/screens/favlist.dart';
import 'package:cinexa/screens/tvshows_screen.dart';
import 'package:cinexa/service/fetch_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'movie_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<MovieCategory>> popularMovies;
  late Future<List<MovieCategory>> topRatedMovies;
  late Future<List<MovieCategory>> upcomingMovies;
  late Future<List<MovieCategory>> nowPlayingMovies;
  FetchData? _fetchMovies = FetchData();
  Movie? movie;
  String? appBarText;
  bool _darkTheme = true;
  int _selectedIndex = 0;

  @override
  void initState() {
    popularMovies = _fetchMovies!.fetchMoviesOfCategory("popular");
    topRatedMovies = _fetchMovies!.fetchMoviesOfCategory("top_rated");
    upcomingMovies = _fetchMovies!.fetchMoviesOfCategory("upcoming");
    nowPlayingMovies = _fetchMovies!.fetchMoviesOfCategory("now_playing");
    checkIfDarkmodeEnabled();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   iconTheme: IconTheme.of(context).copyWith(),
        //   automaticallyImplyLeading: false,
        //   title: appBarWidget(context),
        //   shadowColor: _darkTheme ? Colors.white : Colors.black,
        // ),
        body: body(context),
        bottomNavigationBar: navigationBar(),
      ),
    );
  }

  BottomNavigationBar navigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      items: [
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
          label: 'Bookmarks',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.search),
        //   label: 'Search',
        // ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: kPrimaryColor,
      onTap: _onItemTapped,
    );
  }

  Widget body(BuildContext context) {
    switch (_selectedIndex) {
      case 0:
        return MovieView(
          popularMovies: popularMovies,
          topRatedMovies: topRatedMovies,
          upcomingMovies: upcomingMovies,
          nowPlayingMovies: nowPlayingMovies,
        );
      case 1:
        return TvShowsScreen();
      case 2:
        return FavlistScreen();
      default:
        return Container();
    }
  }

  Row appBarWidget(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.movie),
        SizedBox(width: 10),
        Text(
          (_selectedIndex == 0)
              ? "Movies"
              : (_selectedIndex == 1)
                  ? "TV Shows"
                  : (_selectedIndex == 2)
                      ? "Bookmarks"
                      : "Search",
          style: Theme.of(context).textTheme.headline6!,
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
