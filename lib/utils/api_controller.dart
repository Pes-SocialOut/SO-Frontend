// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:so_frontend/feature_navigation/screens/navigation.dart';
import 'package:so_frontend/feature_user/screens/welcome_screen.dart';
import 'package:so_frontend/main.dart';

class APICalls {
  static final APICalls _instance = APICalls._internal();

  // Seguramente se pueda usar patrón singleton.
  final String _REFRESH_TOKEN_PREFS = 'socialout_refresh_token';

  final String API_URL = 'socialout-develop.herokuapp.com';
  final String _REFRESH_ENDPOINT = '/v1/users/refresh';
  final int _UNAUTHORIZED = 401;

  String _USER_ID = '';
  String _ACCESS_TOKEN = '';
  String _REFRESH_TOKEN = '';

  String getCurrentUser() {
    //print("userID: "+_USER_ID);
    return _USER_ID;
  }

  String getCurrentRefresh() {
    return _REFRESH_TOKEN;
  }

  String getCurrentAccess() {
    return _ACCESS_TOKEN;
  }

  void initialize(String userId, String accessToken, String refreshToken,
      bool keepLoginInPreferences) async {
    _USER_ID = userId;
    _ACCESS_TOKEN = accessToken;
    _REFRESH_TOKEN = refreshToken;

    if (keepLoginInPreferences) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_REFRESH_TOKEN_PREFS, _REFRESH_TOKEN);
    }
  }

  void tryInitializeFromPreferences() async {
    // Esta función se llama al iniciar la aplicación. Determina si el usuario debe hacer login o si ya "se acuerda".
    // Leer las preferences, buscar "socialout_refresh". Si no existe redirecciona a la screen de logIn
    final prefs = await SharedPreferences.getInstance();
    // ignore: unnecessary_null_comparison
    if (prefs != null) {
      final String? refresh_prefs = prefs.getString(_REFRESH_TOKEN_PREFS);
      // ignore: unnecessary_null_comparison
      if (refresh_prefs.toString() != null) {
        // Si hay refresh token, iniciar sesión automáticamente llamando al endpoint de refresh de la API.
        // Si la operación es aceptada redirecciona a la home screen. Si no redirecciona al logIn.
        _REFRESH_TOKEN = refresh_prefs.toString();
        _refresh(() => _redirectToHomeScreen(), () => _redirectToLogin());
      } else {
        _redirectToLogin();
      }
    }
  }

  Future<dynamic> getItem(String endpoint, List<String> pathParams) async {
    final uri = buildUri(endpoint, pathParams, null);
    final response = await http.get(uri, headers: {
      'Authorization': 'Bearer $_ACCESS_TOKEN',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == _UNAUTHORIZED) {
      return _refresh(
          () => getItem(endpoint, pathParams), () => _redirectToLogin());
    }
    return response;
  }

  Future<dynamic> getCollection(String endpoint, List<String> pathParams,
      Map<String, String>? queryParams) async {
    final uri = buildUri(endpoint, pathParams, queryParams);
    final response = await http.get(uri, headers: {
      'Authorization': 'Bearer $_ACCESS_TOKEN',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == _UNAUTHORIZED) {
      return _refresh(() => getCollection(endpoint, pathParams, queryParams),
          () => _redirectToLogin());
    }
    return response;
  }

  Future<dynamic> postItem(String endpoint, List<String> pathParams,
      Map<String, dynamic>? bodyData) async {
    final uri = buildUri(endpoint, pathParams, {});
    final response = await http.post(uri, body: jsonEncode(bodyData), headers: {
      'Authorization': 'Bearer $_ACCESS_TOKEN',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == _UNAUTHORIZED) {
      return _refresh(() => postItem(endpoint, pathParams, bodyData),
          () => _redirectToLogin());
    }
    return response;
  }

  Future<dynamic> putItem(String endpoint, List<String> pathParams,
      Map<String, dynamic>? bodyData) async {
    final uri = buildUri(endpoint, pathParams, {});
    final response = await http.put(uri, body: json.encode(bodyData), headers: {
      'Authorization': 'Bearer $_ACCESS_TOKEN',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == _UNAUTHORIZED) {
      return _refresh(
          () => putItem(endpoint, pathParams, bodyData),
          () => _redirectToLogin());
    } 
    return response;
  }

  Future<dynamic> deleteItem(String endpoint, List<String> pathParams) async {
    final uri = buildUri(endpoint, pathParams, null);
    print(uri);
    final response = await http.delete(uri, headers: {
      'Authorization': 'Bearer $_ACCESS_TOKEN',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == _UNAUTHORIZED) {
      return _refresh(() => deleteItem(endpoint, pathParams),
          () => _redirectToLogin());
    } 
    return response;
  }

  void logOut() async {
    _USER_ID = '';
    _ACCESS_TOKEN = '';
    _REFRESH_TOKEN = '';
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_REFRESH_TOKEN_PREFS);
    _redirectToLogin();
  }

  Future<dynamic> _refresh(Function onSuccess, Function onError) async {
    // Llama a refresh, si es correcto setea las variables y llama a onSuccess. Si no llama a onError
    final response = await http
        .get(Uri.parse('https://' + API_URL + _REFRESH_ENDPOINT), headers: {
      'Authorization': 'Bearer $_REFRESH_TOKEN',
      'Content-Type': 'application/json'
    });
    if (response.statusCode ~/ 100 == 2) {
      Map<String, dynamic> credentials = jsonDecode(response.body);
      _USER_ID = credentials['id'].toString();
      _ACCESS_TOKEN = credentials['access_token'].toString();
      //print("_USER_ID: "+ _USER_ID);
      //print("_ACCESS_TOKEN: "+ _ACCESS_TOKEN);
      if (credentials.containsKey('refresh_token')) {
        _REFRESH_TOKEN = credentials['refresh_token'].toString();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_REFRESH_TOKEN_PREFS, _REFRESH_TOKEN);
      }
      return onSuccess();
    } else {
      onError();
    }
    return response;
  }

  Uri buildUri(String endpoint, List<String> pathParams,
      Map<String, String>? queryParams) {
    String formattedEndpoint = endpoint;
    pathParams.forEachIndexed((idx, param) =>
        formattedEndpoint = formattedEndpoint.replaceAll(":$idx", param));
    return Uri.https(API_URL, formattedEndpoint, queryParams);
  }

  void _redirectToLogin() {
    // ignore: todo
    // TODO: Navegar a la login screen
    navigatorKey.currentState!.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const WelcomeScreen()), (route) => false);
  }

  void _redirectToHomeScreen() {
    // ignore: todo
    // TODO: Navegar a la home screen
    navigatorKey.currentState!.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const NavigationBottomBar()), (route) => false);
  }

  factory APICalls() {
    return _instance;
  }

  APICalls._internal();
}
