import 'dart:convert';
import 'package:http/http.dart' as http;

class UserAPI {
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
}
