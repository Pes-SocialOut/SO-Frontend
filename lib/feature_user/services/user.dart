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

final String url = "https://socialout-develop.herokuapp.com/v1/users/";

//API_URL/v1/users/:id/pw
Future<http.Response> putPassword(
    String oldPass, String newPass, String id) async {
  return http.post(
    Uri.parse(url + id + "/pw"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'old': oldPass,
      'new': newPass,
    }),
  );
}

  /*POST “API_URL/v1/users/:id/pw”
  Header Authorization: Bearer ”token”
  Body (json):
  {
    old: str
    new: str	
  }
  */
