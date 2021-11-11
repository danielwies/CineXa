import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  static final String routeName = "/moviedetailscreen";
  const MovieDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(),
        title: Text("Details"),
        shadowColor: Colors.grey,
      ),
      body: Container(
        color: Colors.blue,
      ),
    );
  }
}
