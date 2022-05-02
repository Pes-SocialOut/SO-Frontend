import 'dart:convert';
import 'package:http/http.dart' as http;

class DeleteEventAPI {

  final String url = 'https://socialout-develop.herokuapp.com/v2/events/';

  Future<List> deleteEventById(String eventId) async {

    final response = await http.delete(Uri.parse(url + eventId));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }

    
    return [];
  }
}