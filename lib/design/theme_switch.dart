import 'package:cinexa/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSwitchProvider extends ChangeNotifier {
  ThemeData? _selectedTheme;
  Typography? defaultTypography;
  SharedPreferences? prefs;

  ThemeData light = ThemeData.light().copyWith(
    primaryColor: Colors.blue,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: kPrimaryColor,
      unselectedIconTheme: IconThemeData(color: Colors.grey),
      unselectedItemColor: Colors.grey,
    ),
    brightness: Brightness.light,
    canvasColor: Colors.white,
    backgroundColor: Colors.blue,
    appBarTheme: AppBarTheme(color: Colors.white),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      subtitle1: TextStyle(color: Colors.black),
      subtitle2: TextStyle(color: Colors.black),
      bodyText2: TextStyle(color: Colors.black),
      headline6: TextStyle(color: Colors.black),
    ),
    iconTheme: IconThemeData(color: Colors.black),
  );

  ThemeData dark = ThemeData.dark().copyWith(
    primaryColor: Colors.blue,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: kPrimaryColor,
      unselectedLabelStyle: TextStyle(color: Colors.black),
      unselectedIconTheme: IconThemeData(color: Colors.grey),
      unselectedItemColor: Colors.grey,
    ),
    brightness: Brightness.dark,
    canvasColor: Colors.black,
    backgroundColor: Colors.blue,
    appBarTheme: AppBarTheme(color: Colors.black),
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      subtitle1: TextStyle(color: Colors.white),
      subtitle2: TextStyle(color: Colors.white),
      bodyText2: TextStyle(color: Colors.white),
      headline6: TextStyle(color: Colors.white),
    ),
    iconTheme: IconThemeData(color: Colors.white),
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
