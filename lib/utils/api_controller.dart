import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APICalls {
    // Seguramente se pueda usar patrón singleton.
    final String _REFRESH_TOKEN_PREFS = 'socialout_refresh_token';

    final String API_URL = 'https://socialout-develop.herokuapp.com';
    final String REFRESH_ENDPOINT = '/v1/users/refresh';
    final UNAUTHORIZED = 401;

    String USER_ID;
    String ACCESS_TOKEN;
    String REFRESH_TOKEN;

    void initialize(Stirng userId, String accessToken, String refreshToken, bool keepLoginInPreferences) async {
        USER_ID = userId;
        ACCESS_TOKEN = accessToken;
        REFRESH_TOKEN = refreshToken;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_REFRESH_TOKEN_PREFS, REFRESH_TOKEN);
    }

    void tryInitializeFromPreferences() async {
        // Esta función se llama al iniciar la aplicación. Determina si el usuario debe hacer login o si ya "se acuerda".
        // Leer las preferences, buscar "socialout_refresh". Si no existe redirecciona a la screen de logIn
        final prefs = await SharedPreferences.getInstance();
        final String? refresh = prefs.getString(_REFRESH_TOKEN_PREFS);
        if (refresh == null) redirectToLogin();
        else {
            // Si hay refresh token, iniciar sesión automáticamente llamando al endpoint de refresh de la API.
            // Si la operación es aceptada redirecciona a la home screen. Si no redirecciona al logIn.
            REFRESH_TOKEN = refresh;
            refresh(() => redirectToHomeScreen(), () => redirectToLogin());
        }
    }

    void getItem(String endpoint, List<String> pathParams, Function onSuccess, Function onError) async {
        String formattedEndpoint = endpoint;
        pathParams.forEachIndexed((idx, param) => formattedEndpoint = formattedEndpoint.replaceAll(":$idx", param));
        final uri = Uri.https(API_URL, formattedEndpoint, {});
        final response = await http.get(uri, headers: {
            HttpHeaders.authorizationHeader: 'Bearer $ACCESS_TOKEN',
            HttpHeaders.contentTypeHeader: 'application/json'
        });
        if (response.statusCode == UNAUTHORIZED) { // Intenta hacer refresh y relanzar la llamada a getItem
            refresh(() => getItem(endpoint, pathParams, onSuccess, onError), () => redirectToLogin());
        } else if (response.statusCode ~/ 100 == 2) {
            onSuccess(jsonDecode(response.body));
        } else {
            onError(jsonDecode(response.body)['error_message'], response.statusCode);
        }
    }

    void getCollection(String endpoint, List<String> pathParams, Map<String, String> queryParams, Function onSuccess, Function onError) async {
        String formattedEndpoint = endpoint;
        pathParams.forEachIndexed((idx, param) => formattedEndpoint = formattedEndpoint.replaceAll(":$idx", param));
        final uri = Uri.https(API_URL, formattedEndpoint, queryParams);
        final response = await http.get(uri, headers: {
            HttpHeaders.authorizationHeader: 'Bearer $ACCESS_TOKEN',
            HttpHeaders.contentTypeHeader: 'application/json'
        });
        if (response.statusCode == UNAUTHORIZED) { // Intenta hacer refresh y relanzar la llamada a getCollection
            refresh(() => getCollection(endpoint, pathParams, queryParams, onSuccess, onError), () => redirectToLogin());
        } else if (response.statusCode ~/ 100 == 2) {
            onSuccess(jsonDecode(response.body));
        } else {
            onError(jsonDecode(response.body)['error_message'], response.statusCode);
        }
    }

    void postItem(String endpoint, List<String> pathParams, Map<String, dynamic> bodyData, Function onSuccess, Function onError) async {

    }

    void putItem(String endpoint, List<String> pathParams, Map<String, dynamic> bodyData, Function onSuccess, Function onError) async {

    }

    void deleteItem(String endpoint, List<String> pathParams, Function onSuccess, Function onError) async {
    
    }

    void logOut() async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(_REFRESH_TOKEN_PREFS);
        redirectToLogin();
    }

    void refresh(Function onSuccess, Function onError) {
        // Llama a refresh, si es correcto setea las variables y llama a onSuccess. Si no llama a onError
        final response = await http.get(API_URL+REFRESH_ENDPOINT, headers: {
            HttpHeaders.authorizationHeader: 'Bearer $REFRESH_TOKEN',
            HttpHeaders.contentTypeHeader: 'application/json'
        });
        if (response.statusCode ~/ 100 == 2) {
            Map<String, String> credentials = jsonDecode(response.body);
            USER_ID = credentials['id'];
            ACCESS_TOKEN = credentials['access_token'];
            REFRESH_TOKEN = credentials['refresh_token'];
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString(_REFRESH_TOKEN_PREFS, REFRESH_TOKEN);
            onSuccess();
        } else {
            onError();
        }
    }

    void redirectToLogin() {
        // Navegar a la login screen
    }

}