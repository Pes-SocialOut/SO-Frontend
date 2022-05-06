import 'dart:convert';
import 'package:http/http.dart' as http;

class GetEventsAPI {
  final String url = 'https://socialout-develop.herokuapp.com/v2/events/';

  Future<List> getEventById(String id) async {
    final response = await http.get(Uri.parse(url + id));

    if (response.statusCode == 200) {
      print("Get event by id successful");
      return json.decode(response.body);
    }

    print("Get event by id ERROR!!!");
    return [];
  }

  // PENDING OF BACKEND URL DEFINITION
  Future<List> getUserEventsByCreator(String creatorId) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }

    return [];
  }
}
