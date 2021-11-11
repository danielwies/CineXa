import 'package:logging/logging.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final _log = Logger('http');

Future<dynamic> getJSON(String path, Map<String, String?>? queryParams) async {
  var apiUrl = "https://api.themoviedb.org/3/";
  var url = apiUrl + "$path";
  print(url);

  if (queryParams != null) {
    var uri = Uri(queryParameters: queryParams);
    url += uri.toString();
  }
  print("url after params added $url");
  _log.fine("GET $url");

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print("Call succesfull: Code 200");
    return json.decode(response.body);
  } else {
    _log.warning("Response: ${response.statusCode}: ${response.body}");
    if (response.statusCode == 403) {
      throw Exception(
        "Error: ${response.statusCode})",
      );
    }
  }
}
