import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateEventsAPI {

  final String url = 'https://socialout-develop.herokuapp.com/v2/events/';


  Future<bool> postEvent(List event) async {

    final newEvent = jsonEncode(event[0]);

    final response = await http.post(
      Uri.parse(url),
      body: newEvent,
      headers: {
        'Content-Type': 'application/json'
      }
    );

    if (response.statusCode == 201) {
      return true;
    }

    return false;
  }
}