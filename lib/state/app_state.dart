import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

final log = Logger('AppState');

class AppState extends ChangeNotifier {
  late SharedPreferences prefs;

  loadState() async {
    prefs = await SharedPreferences.getInstance();

    final settingString = prefs.getString("movie_cart");

    if (settingString == null) {
      log.config("No State found, reset inital state");
    }

    final settingsJSON = json.decode(settingString!);
    log.fine("Settings from SharedPref: " + settingsJSON.toString());
  }
}
