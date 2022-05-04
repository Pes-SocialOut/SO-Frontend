// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final String? refresh_prefs = prefs.getString(_REFRESH_TOKEN_PREFS);
    if (refresh_prefs == null) {
      _redirectToLogin();
    } else {
      // Si hay refresh token, iniciar sesión automáticamente llamando al endpoint de refresh de la API.
      // Si la operación es aceptada redirecciona a la home screen. Si no redirecciona al logIn.
      _REFRESH_TOKEN = refresh_prefs;
      _refresh(() => _redirectToHomeScreen(), () => _redirectToLogin());
    }
  }

  void getItem(String endpoint, List<String> pathParams, Function onSuccess,
      Function onError) async {
    final uri = buildUri(endpoint, pathParams, {});
    final response = await http.get(uri, headers: {
      'Authorization': 'Bearer $_ACCESS_TOKEN',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == _UNAUTHORIZED) {
      _refresh(() => getItem(endpoint, pathParams, onSuccess, onError),
          () => _redirectToLogin());
    } else if (response.statusCode ~/ 100 == 2) {
      onSuccess(jsonDecode(response.body));
    } else {
      String errorMessage = 'No error message provided';
      if (jsonDecode(response.body).containsKey('error_message')) {
        errorMessage = jsonDecode(response.body)['error_message'];
      }
      onError(errorMessage, response.statusCode);
    }
  }

  void getCollection(
      String endpoint,
      List<String> pathParams,
      Map<String, String> queryParams,
      Function onSuccess,
      Function onError) async {
    final uri = buildUri(endpoint, pathParams, queryParams);
    final response = await http.get(uri, headers: {
      'Authorization': 'Bearer $_ACCESS_TOKEN',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == _UNAUTHORIZED) {
      _refresh(
          () => getCollection(
              endpoint, pathParams, queryParams, onSuccess, onError),
          () => _redirectToLogin());
    } else if (response.statusCode ~/ 100 == 2) {
      onSuccess(jsonDecode(response.body));
    } else {
      String errorMessage = 'No error message provided';
      if (jsonDecode(response.body).containsKey('error_message')) {
        errorMessage = jsonDecode(response.body)['error_message'];
      }
      onError(errorMessage, response.statusCode);
    }
  }

  void postItem(
      String endpoint,
      List<String> pathParams,
      Map<String, dynamic> bodyData,
      Function onSuccess,
      Function onError) async {
    final uri = buildUri(endpoint, pathParams, {});
    final response = await http.post(uri, body: bodyData, headers: {
      'Authorization': 'Bearer $_ACCESS_TOKEN',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == _UNAUTHORIZED) {
      _refresh(
          () => postItem(endpoint, pathParams, bodyData, onSuccess, onError),
          () => _redirectToLogin());
    } else if (response.statusCode ~/ 100 == 2) {
      onSuccess(jsonDecode(response.body));
    } else {
      String errorMessage = 'No error message provided';
      if (jsonDecode(response.body).containsKey('error_message')) {
        errorMessage = jsonDecode(response.body)['error_message'];
      }
      onError(errorMessage, response.statusCode);
    }
  }

  void putItem(
      String endpoint,
      List<String> pathParams,
      Map<String, dynamic> bodyData,
      Function onSuccess,
      Function onError) async {
    final uri = buildUri(endpoint, pathParams, {});
    final response = await http.put(uri, body: bodyData, headers: {
      'Authorization': 'Bearer $_ACCESS_TOKEN',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == _UNAUTHORIZED) {
      _refresh(
          () => putItem(endpoint, pathParams, bodyData, onSuccess, onError),
          () => _redirectToLogin());
    } else if (response.statusCode ~/ 100 == 2) {
      onSuccess(jsonDecode(response.body));
    } else {
      String errorMessage = 'No error message provided';
      if (jsonDecode(response.body).containsKey('error_message')) {
        errorMessage = jsonDecode(response.body)['error_message'];
      }
      onError(errorMessage, response.statusCode);
    }
  }

  void deleteItem(String endpoint, List<String> pathParams, Function onSuccess,
      Function onError) async {
    final uri = buildUri(endpoint, pathParams, {});
    final response = await http.post(uri, headers: {
      'Authorization': 'Bearer $_ACCESS_TOKEN',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == _UNAUTHORIZED) {
      _refresh(() => deleteItem(endpoint, pathParams, onSuccess, onError),
          () => _redirectToLogin());
    } else if (response.statusCode ~/ 100 == 2) {
      onSuccess(jsonDecode(response.body));
    } else {
      String errorMessage = 'No error message provided';
      if (jsonDecode(response.body).containsKey('error_message')) {
        errorMessage = jsonDecode(response.body)['error_message'];
      }
      onError(errorMessage, response.statusCode);
    }
  }

  void logOut() async {
    _USER_ID = '';
    _ACCESS_TOKEN = '';
    _REFRESH_TOKEN = '';
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_REFRESH_TOKEN_PREFS);
    _redirectToLogin();
  }

  void _refresh(Function onSuccess, Function onError) async {
    // Llama a refresh, si es correcto setea las variables y llama a onSuccess. Si no llama a onError
    final response = await http.get(Uri.parse(API_URL + _REFRESH_ENDPOINT),
        headers: {
          'Authorization': 'Bearer $_REFRESH_TOKEN',
          'Content-Type': 'application/json'
        });
    if (response.statusCode ~/ 100 == 2) {
      Map<String, String> credentials = jsonDecode(response.body);
      _USER_ID = credentials['id'].toString();
      _ACCESS_TOKEN = credentials['access_token'].toString();
      if (credentials.containsKey('refresh_token')) {
        _REFRESH_TOKEN = credentials['refresh_token'].toString();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_REFRESH_TOKEN_PREFS, _REFRESH_TOKEN);
      }
      onSuccess();
    } else {
      onError();
    }
  }

  Uri buildUri(String endpoint, List<String> pathParams,
      Map<String, String> queryParams) {
    String formattedEndpoint = endpoint;
    pathParams.forEachIndexed((idx, param) =>
        formattedEndpoint = formattedEndpoint.replaceAll(":$idx", param));
    return Uri.https(API_URL, formattedEndpoint, queryParams);
  }

  void _redirectToLogin() {
    // ignore: todo
    // TODO: Navegar a la login screen
  }

  void _redirectToHomeScreen() {
    // ignore: todo
    // TODO: Navegar a la home screen
  }

  factory APICalls() {
    return _instance;
  }

  APICalls._internal();
}
