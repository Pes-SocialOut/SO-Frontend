// ignore_for_file: camel_case_types

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:so_frontend/utils/api_controller.dart';

class userAPI {
  final String basicUrl = "https://socialout-develop.herokuapp.com/v1/users/";

  /* Comprobar que un email socialout existe o no en la BD */
  Future<Map<String, dynamic>> checkUserEmail(email) async {
    String _path = 'register/check?type=socialout&email=';

    String finalUri = basicUrl + _path + email;
    final response = await http.get(Uri.parse(finalUri));

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

  /* Comprobar que un Facebook socialout existe o no en la BD */
  Future<List> checkUserFacebook(ftoken) async {
    String _path = 'register/check?type=facebook&gtoken=';

    final response = await http.get(Uri.parse(basicUrl + _path + ftoken));

    if (response.statusCode != 200) {
      // return error
    }
    return json.decode(response.body);
  }

  /* Get profile of a user given a access token */
  Future<List> getDataAcessTokenGoogle(gtoken) async {
    String googleProfileGetter =
        "https://www.googleapis.com/oauth2/v3/userinfo?access_token=";

    final response = await http.get(Uri.parse(googleProfileGetter + gtoken));

    if (response.statusCode != 200) {
      // return error
    }
    return json.decode(response.body);
  }

  /*ultimo paso de registro*/
  Future<int> finalRegistrer(
      String email,
      String passw,
      String username,
      String description,
      String languages,
      String hobbies,
      String codiVeri) async {
    String _path = 'register/socialout';
    String finalUri = basicUrl + _path;
    var str = {
      "email": email,
      "password": passw,
      "username": username,
      "description": description,
      "languages": languages,
      "hobbies": hobbies,
      "verification": codiVeri
    };
    final response = await http.post(Uri.parse(finalUri),
        body: jsonEncode(str), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      String accessToken = json.decode(response.body)['access_token'];
      String userID = json.decode(response.body)['id'];
      String refreshToken = json.decode(response.body)['refresh_token'];
      APICalls a = APICalls();
      a.initialize(userID, accessToken, refreshToken, true);
    } else {
      print('status code : ' + response.statusCode.toString());
    }
    return response.statusCode;
  }

  /* check email para Login con cuenta SocialOut */
  Future<Map<String, dynamic>> checkloginSocialOut(String email) async {
    String _path = 'login/check?type=socialout&email=';

    String finalUri = basicUrl + _path + email;
    final response = await http.get(Uri.parse(finalUri));

    return json.decode(response.body);
  }

  /* login con cuenta socialOut*/
  Future<int> loginSocialOut(String email, String password) async {
    String _path = 'login/socialout';
    String finalUri = basicUrl + _path;
    var str = {"email": email, "password": password};
    final response = await http.post(Uri.parse(finalUri),
        body: jsonEncode(str), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      String accessToken = json.decode(response.body)['access_token'];
      String userID = json.decode(response.body)['id'];
      String refreshToken = json.decode(response.body)['refresh_token'];
      APICalls a = APICalls();
      a.initialize(userID, accessToken, refreshToken, true);
    } else {
      print('status code : ' + response.statusCode.toString());
    }
    return response.statusCode;
  }
}
