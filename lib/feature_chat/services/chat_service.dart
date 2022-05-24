import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:so_frontend/utils/api_controller.dart';

class chatAPI {
  final String basicUrl = "https://socialout-develop.herokuapp.com/v1/users/";

  /* Crear el chat */
  Future<Map<String, dynamic>> checkUserEmail(email) async {
    String _path = 'v1/chat/';

    String finalUri = basicUrl + _path + email;
    final response = await http.get(Uri.parse(finalUri));
    return json.decode(response.body);
  }


}