import 'package:cinexa/config/movie_cart.dart';
import 'package:cinexa/config/tvshow_cart.dart';
import 'package:cinexa/design/theme_switch.dart';
import 'package:cinexa/screens/favlist.dart';
import 'package:cinexa/screens/home_screen.dart';
import 'package:cinexa/screens/movie_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then(
    (prefs) {
      var isDarkTheme = prefs.getBool("darkTheme") ?? false;

      return runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => ThemeSwitchProvider(isDarkTheme),
            ),
            ChangeNotifierProvider(
              create: (context) => MovieCart(),
            ),
            ChangeNotifierProvider(
              create: (context) => TvShowCart(),
            ),
          ],
          child: Cinexa(),
        ),
      );
    },
  );
}

class Cinexa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeSwitchProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CineXa',
      themeMode: ThemeMode.system,
      theme: themeNotifier.getTheme(),
      home: HomeScreen(),
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        MovieDetailScreen.routeName: (context) => MovieDetailScreen(),
        FavlistScreen.routeName: (context) => FavlistScreen(),
      },
    );
  }
}
