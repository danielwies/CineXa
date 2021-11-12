import 'package:cinexa/components/header_tile.dart';
import 'package:cinexa/components/content_tile.dart';
import 'package:flutter/material.dart';

class ContentCategoryView extends StatelessWidget {
  const ContentCategoryView(
      {Key? key, required this.contentToShow, required this.category})
      : super(key: key);

  final Future<List<dynamic>> contentToShow;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderTile(leadingText: category, trailingText: "See all"),
        Container(
          height: 270,
          child: FutureBuilder(
            future: contentToShow,
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    dynamic selectedContentType = snapshot.data![index];
                    return ContentTile(
                      id: selectedContentType.id,
                      posterPath: selectedContentType.posterPath,
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return Center(child: const CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
