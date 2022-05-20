// ignore_for_file: file_names, camel_case_types, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:so_frontend/utils/api_controller.dart';

class userAPI {
  final String basicUrl = "https://socialout-develop.herokuapp.com/v1/users/";
  final String basicUrl2 = "https://socialout-develop.herokuapp.com/v2/users/";

  /* Comprobar que un email socialout existe o no en la BD */
  Future<Map<String, dynamic>> checkUserEmail(email) async {
    String _path = 'register/check?type=socialout&email=';

    String finalUri = basicUrl + _path + email;
    final response = await http.get(Uri.parse(finalUri));
    return json.decode(response.body);
  }

  /* Comprobar que el email para recuperar contraseña existe */
  Future<Map<String, dynamic>> checkEmailForNewPassword(email) async {
    String _path = 'forgot_pw?email=';
    String finalUri = basicUrl2 + _path + email;
    print("final_uri: " + finalUri);
    final response = await http.get(Uri.parse(finalUri));
    return json.decode(response.body);
  }

  /* Comprobar que un Google socialout existe o no en la BD */
  Future<http.Response> checkUserGoogle(gtoken) async {
    String _path = 'register/check?type=google&token=';

    final response = await http.get(Uri.parse(basicUrl + _path + gtoken));
    if (response.statusCode != 200) {
      // return error
    }
    return response;
  }

  /* Comprobar que un Facebook socialout existe o no en la BD */
  Future<http.Response> checkUserFacebook(ftoken) async {
    String _path = 'register/check?type=facebook&token=';

    final response = await http.get(Uri.parse(basicUrl + _path + ftoken));

    if (response.statusCode != 200) {
      // return error
    }
    return response;
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
      List languages,
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
      //print('status code : ' + response.statusCode.toString());
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

  /* update password and credentials*/
  Future<int> finalPasswordRecovery(
      String email, String passw, String codiVeri) async {
    String _path = 'forgot_pw';
    String finalUri = basicUrl2 + _path;
    var str = {"email": email, "password": passw, "verification": codiVeri};
    final response = await http.post(Uri.parse(finalUri),
        body: jsonEncode(str), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      String accessToken = json.decode(response.body)['access_token'];
      String userID = json.decode(response.body)['id'];
      String refreshToken = json.decode(response.body)['refresh_token'];
      APICalls a = APICalls();
      a.initialize(userID, accessToken, refreshToken, true);
    } else {
      //print('status code : ' + response.statusCode.toString());
    }
    return response.statusCode;
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
      //print('status code : ' + response.statusCode.toString());
    }
    return response.statusCode;
  }

  /*paso de para link SocialOut y cuenta social*/
  Future<int> linkRegistrerAndLogin(String email, String passw, String codiVeri,
      String type, String token) async {
    String _path = 'auth_method';
    String finalUri = basicUrl + _path;

    var str = {};

    if (type == "socialout") {
      str = {
        "type": type,
        "credentials": {
          "email": email,
          "password": passw,
          "verification": codiVeri
        }
      };
    } else if (type == "google" || type == "facebook") {
      str = {
        "type": type,
        "credentials": {
          "token": token,
        },
      };
    }

    final response = await http.post(Uri.parse(finalUri),
        body: json.encode(str), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      String accessToken = json.decode(response.body)['access_token'];
      String userID = json.decode(response.body)['id'];
      String refreshToken = json.decode(response.body)['refresh_token'];
      APICalls a = APICalls();
      a.initialize(userID, accessToken, refreshToken, true);
    } else {
      //print('status code : ' + response.statusCode.toString());
      //print('error_message: ' + json.decode(response.body)['error_message']);
    }
    return response.statusCode;
  }

  Future<int> finalRegistrerGoogle(
    String tokenGoogle,
    String username,
    String description,
    String languages,
    String hobbies,
  ) async {
    String _path = 'register/google';
    String finalUri = basicUrl + _path;
    var str = {
      "token": tokenGoogle,
      "username": username,
      "description": description,
      "languages": languages,
      "hobbies": hobbies,
    };
    final response = await http.post(Uri.parse(finalUri),
        body: jsonEncode(str), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      String accessToken = json.decode(response.body)['access_token'];
      String userID = json.decode(response.body)['id'];
      String refreshToken = json.decode(response.body)['refresh_token'];
      APICalls a = APICalls();
      a.initialize(userID, accessToken, refreshToken, true);
      //a.getItem('/v1/users/:0', [a.getCurrentUser()], (body) => print(body),
      //    (msg, err) => print(err));
    } else {
      //print('status code : ' + response.statusCode.toString());
      //print('error_message: ' + json.decode(response.body)['error_message']);
    }
    return response.statusCode;
  }

  Future<int> finalRegistrerFacebook(
    String tokenFacebook,
    String username,
    String description,
    String languages,
    String hobbies,
  ) async {
    String _path = 'register/facebook';
    String finalUri = basicUrl + _path;
    var str = {
      "token": tokenFacebook,
      "username": username,
      "description": description,
      "languages": languages,
      "hobbies": hobbies,
    };
    final response = await http.post(Uri.parse(finalUri),
        body: jsonEncode(str), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      String accessToken = json.decode(response.body)['access_token'];
      String userID = json.decode(response.body)['id'];
      String refreshToken = json.decode(response.body)['refresh_token'];
      APICalls a = APICalls();
      a.initialize(userID, accessToken, refreshToken, true);
      //a.getItem('/v1/users/:0', [a.getCurrentUser()], (body) => print(body),
      //    (msg, err) => print(err));
    } else {
      //print('status code : ' + response.statusCode.toString());
      //print('error_message: ' + json.decode(response.body)['error_message']);
    }
    return response.statusCode;
  }

  Future<http.Response> logInGoogle(
    String tokenGoogle,
  ) async {
    String _path = 'login/google';
    String finalUri = basicUrl + _path;
    var str = {
      "token": tokenGoogle,
    };
    final response = await http.post(Uri.parse(finalUri),
        body: jsonEncode(str), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      String accessToken = json.decode(response.body)['access_token'];
      String userID = json.decode(response.body)['id'];
      String refreshToken = json.decode(response.body)['refresh_token'];

      APICalls a = APICalls();
      a.initialize(userID, accessToken, refreshToken, true);
      //a.getItem('/v1/users/:0', [a.getCurrentUser()], (body) => print(body),
      //    (msg, err) => print(err));
    } else {
      //print('status code : ' + response.statusCode.toString());
      //print('error_message: ' + json.decode(response.body)['error_message']);
    }
    return response;
  }

  Future<http.Response> logInFacebook(
    String tokenGoogle,
  ) async {
    String _path = 'login/facebook';
    String finalUri = basicUrl + _path;
    var str = {
      "token": tokenGoogle,
    };
    final response = await http.post(Uri.parse(finalUri),
        body: jsonEncode(str), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      String accessToken = json.decode(response.body)['access_token'];
      String userID = json.decode(response.body)['id'];
      String refreshToken = json.decode(response.body)['refresh_token'];

      APICalls a = APICalls();
      a.initialize(userID, accessToken, refreshToken, true);
      //a.getItem('/v1/users/:0', [a.getCurrentUser()], (body) => print(body),
      //    (msg, err) => print(err));
    } else {
      //print('status code : ' + response.statusCode.toString());
      //print('error_message: ' + json.decode(response.body)['error_message']);
    }
    return response;
  }
}
