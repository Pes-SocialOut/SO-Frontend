import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APICalls {
  static final APICalls _instance = APICalls._internal();

  // Seguramente se pueda usar patrón singleton.
  final String _refreshTokenPrefs = 'socialoutrefreshToken';

  final String apiUrl = 'https://socialout-develop.herokuapp.com';
  final String refreshEndpoint = '/v1/users/refresh';
  final int unauthorized = 401;

  String userID = '';
  String accessToken = '';
  String refreshToken = '';

  String getCurrentUser() {
    return userID;
  }

  void initialize(String userId, String accessToken, String refreshToken,
      bool keepLoginInPreferences) async {
    userID = userId;
    accessToken = accessToken;
    refreshToken = refreshToken;

    if (keepLoginInPreferences) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_refreshTokenPrefs, refreshToken);
    }
  }

  void tryInitializeFromPreferences() async {
    // Esta función se llama al iniciar la aplicación. Determina si el usuario debe hacer login o si ya "se acuerda".
    // Leer las preferences, buscar "socialout_refresh". Si no existe redirecciona a la screen de logIn
    final prefs = await SharedPreferences.getInstance();
    final String? refreshPrefs = prefs.getString(_refreshTokenPrefs);
    // ignore: unrelated_type_equality_checks
    if (refreshPrefs == Null) {
      _redirectToLogin();
    } else {
      // Si hay refresh token, iniciar sesión automáticamente llamando al endpoint de refresh de la API.
      // Si la operación es aceptada redirecciona a la home screen. Si no redirecciona al logIn.
      refreshToken = refreshPrefs!;
      _refresh(() => _redirectToHomeScreen(), () => _redirectToLogin());
    }
  }

  void getItem(String endpoint, List<String> pathParams, Function onSuccess,
      Function onError) async {
    final uri = _buildUri(endpoint, pathParams, {});
    final response = await http.get(uri, headers: {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == unauthorized) {
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
    final uri = _buildUri(endpoint, pathParams, queryParams);
    final response = await http.get(uri, headers: {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == unauthorized) {
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
    final uri = _buildUri(endpoint, pathParams, {});
    final response = await http.post(uri, body: bodyData, headers: {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == unauthorized) {
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
    final uri = _buildUri(endpoint, pathParams, {});
    final response = await http.put(uri, body: bodyData, headers: {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == unauthorized) {
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
    final uri = _buildUri(endpoint, pathParams, {});
    final response = await http.post(uri, headers: {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == unauthorized) {
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
    userID = '';
    accessToken = '';
    refreshToken = '';
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_refreshTokenPrefs);
    _redirectToLogin();
  }

  void _refresh(Function onSuccess, Function onError) async {
    // Llama a refresh, si es correcto setea las variables y llama a onSuccess. Si no llama a onError
    var url = (apiUrl + refreshEndpoint);
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $refreshToken',
      'Content-Type': 'application/json'
    });
    if (response.statusCode ~/ 100 == 2) {
      userID = jsonDecode(response.body)["id"];
      accessToken = jsonDecode(response.body)['access_token'];
      if (jsonDecode(response.body).containsKey('refresh_token')) {
        refreshToken = jsonDecode(response.body)['refresh_token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_refreshTokenPrefs, refreshToken);
      }
      onSuccess();
    } else {
      onError();
    }
  }

  Uri _buildUri(String endpoint, List<String> pathParams,
      Map<String, String> queryParams) {
    String formattedEndpoint = endpoint;
    pathParams.forEachIndexed((idx, param) =>
        formattedEndpoint = formattedEndpoint.replaceAll(":$idx", param));
    return Uri.https(apiUrl, formattedEndpoint, queryParams);
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
