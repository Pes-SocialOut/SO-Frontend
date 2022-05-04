// ignore_for_file: camel_case_types

import 'dart:convert';
import 'package:http/http.dart' as http;

class userAPI {
  final String urlToken = "https://socialout-develop.herokuapp.com/v1/users/";
  String token = '';
  String refreshToken = '';

  /* Comprobar que un email socialout existe o no en la BD */
  Future<Map<String, dynamic>> checkUserEmail(email) async {
    String _path = 'register/check?type=socialout&email=';

    final response = await http.get(Uri.parse(urlToken + _path + email));

    return json.decode(response.body);
  }

  /*ultimo paso de registro*/
  Future<int> finalRegistrer(
      email, passw, username, description, languages, hobbies, codiVeri) async {
    String _path = 'register/socialout';

    final response = await http.post(
      Uri.parse(urlToken + _path),
      body: {
        "email": email,
        "password": passw,
        "username": username,
        "description": description,
        "languages": languages,
        "hobbies": hobbies,
        "verification": codiVeri
      },
    );

    if (response.statusCode == 200) {
      //access-tokken + id + refresh-token
    }
    return response.statusCode;
  }
}
