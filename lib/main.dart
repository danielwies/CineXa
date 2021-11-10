import 'package:cinexa/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Cinexa());
}

class Cinexa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
