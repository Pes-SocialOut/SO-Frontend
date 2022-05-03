import 'dart:convert';
import 'package:http/http.dart' as http;

class EditEventsAPI {

  final String url = 'https://socialout-develop.herokuapp.com/v2/events/';

  Future<bool> updateEvent(String id, List event) async {

    String body = jsonEncode(event[0]);

    final String putUrl = url + id;
    final response = await http.put(
      Uri.parse(putUrl),
      body: body,
      headers: {
        'Content-Type': 'application/json'
      }
    );
    
    if (response.statusCode == 200) {
      print("Event updated successfully!");
      return true;
    }
    print("Event update ERROR!!!");
    return false;
  }
}