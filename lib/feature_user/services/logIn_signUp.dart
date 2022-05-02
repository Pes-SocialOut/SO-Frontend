// ignore_for_file: camel_case_types

import 'dart:convert';
import 'package:http/http.dart' as http;

class userAPI {
  final String basicUrl = "https://socialout-develop.herokuapp.com/v1/users/";
  String token = '';
  String refreshToken = '';

  /* Comprobar que un email socialout existe o no en la BD */
  Future<List> checkUserEmail(email) async {
    String _path = 'register/check?type=socialout&email=';

    final response = await http.get(Uri.parse(basicUrl + _path + email));

    if (response.statusCode != 200) {
      // return error
    }
    return json.decode(response.body);
  }

  /* Comprobar que un Google socialout existe o no en la BD */
  Future<List> checkUserGoogle(gtoken) async {
    String _path = 'register/check?type=google&gtoken=';

    final response = await http.get(Uri.parse(basicUrl + _path + gtoken));

    if (response.statusCode != 200) {
      // return error
    }
    return json.decode(response.body);
  }

  /*ultimo paso de registro*/
  Future<int> finalRegistrer(
      email, passw, username, description, languages, hobbies, codiVeri) async {
    String _path = 'register/socialout';

    final response = await http.post(
      Uri.parse(basicUrl + _path),
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
      token = response.body;
    }
    return response.statusCode;
  }
}