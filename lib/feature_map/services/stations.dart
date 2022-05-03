import 'dart:convert';
import 'package:http/http.dart' as http;

class StationsAPI {
  final String url = "https://socialout-develop.herokuapp.com/v1/air/stations/";

  Future<List> getAllStations() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }

    return [];
  }

  /*Future<List> getStation(String id) async {
    final String url2 = url + id;
    final response = await http.get(Uri.parse(url2));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }

    return [];
  }*/
  Future<Map<String, dynamic>> getStation(String id) async {
    final String url2 = url + id;
    final response = await http.get(Uri.parse(url2));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }

    return {};
  }
}
