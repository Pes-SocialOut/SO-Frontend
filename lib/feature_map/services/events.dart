import 'dart:convert';
import 'package:http/http.dart' as http;

class EventsAPI {

  final String url = "https://socialout-develop.herokuapp.com/v1/events/";

  Future<List> getAllEvents() async {

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      
      return json.decode(response.body);
      //debugPrint(tmp[0]["longitud"].toString());
    }


    return [];
  }

}