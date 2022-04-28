import 'dart:convert';
import 'package:http/http.dart' as http;

class EventsAPI {

  final String url = '';


  Future<List> getEvent(String id) async {

    final response = await http.get(Uri.parse(url + '/$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }

    return [];
  }

  Future<List> deleteEvent(String id) async {

    final response = await http.get(Uri.parse(url + '/$id'));

    if (response.statusCode == 202) {
      return json.decode(response.body);
    }
    return [];
  }

  Future<List> getAllEvents() async {

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return [];
  }
}