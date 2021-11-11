import 'package:cinexa/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSwitchProvider extends ChangeNotifier {
  ThemeData? _selectedTheme;
  Typography? defaultTypography;
  SharedPreferences? prefs;

  ThemeData light = ThemeData.light().copyWith(
    // primaryColor: Colors.blue,
    brightness: Brightness.light,
    canvasColor: Colors.white,
    backgroundColor: Colors.blue,
    appBarTheme: AppBarTheme(color: kPrimaryColor),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      subtitle1: TextStyle(color: Colors.black),
      subtitle2: TextStyle(color: Colors.yellow),
      bodyText2: TextStyle(color: Colors.orange),
      headline6: TextStyle(color: Colors.white),
    ),
    iconTheme: IconThemeData(color: Colors.white),
  );

  ThemeData dark = ThemeData.dark().copyWith(
    // primaryColor: Colors.blue,
    brightness: Brightness.dark,
    canvasColor: Colors.black,
    backgroundColor: Colors.blue,
    appBarTheme: AppBarTheme(color: kPrimaryColor),
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      subtitle1: TextStyle(color: Colors.white),
      subtitle2: TextStyle(color: Colors.yellow),
      bodyText2: TextStyle(color: Colors.orange),
      headline6: TextStyle(color: Colors.black),
    ),
    iconTheme: IconThemeData(color: Colors.black),
  );

  ThemeSwitchProvider(bool darkThemeOn) {
    _selectedTheme = darkThemeOn ? dark : light;
  }

  Future<void> swapTheme() async {
    prefs = await SharedPreferences.getInstance();

    if (_selectedTheme == dark) {
      _selectedTheme = light;
      await prefs!.setBool("darkTheme", false);
    } else {
      _selectedTheme = dark;
      await prefs!.setBool("darkTheme", true);
    }
    notifyListeners();
  }

  ThemeData? getTheme() => _selectedTheme;
}
