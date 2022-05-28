import 'dart:convert';
import 'package:http/http.dart' as http;

class UserAPI {
  final String url = "";

  Future<List> getUser() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return [];
  }

  //el put no deberia hacer return, buscar
  Future<void> putUser() async {
    final response = await http.put(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
  }

  /*Future<List> putPassword() async {
  final response = await http.put(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return [];
  }*/
}
