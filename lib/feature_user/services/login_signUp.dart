import 'dart:convert';
import 'package:http/http.dart' as http;

class EventsAPI {
  final String urlToken = "https://socialout-develop.herokuapp.com/v1/user/";
  String token = '';
  String refreshToken = '';

  Future checkUserEmail(email) async {
    String _path = 'register/check?type=';
    String type = 'socialout&email=';

    final response =
        await http.get(Uri.parse(urlToken + _path + type + email));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
  }

  Future userRegistrer(String email, String passw, String codiVeri) async {

    String _path = 'auth_method';
    String type = 'socialout';

    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    data['Type'] = {type};
    data['Credentials'] = [
      {
        "Email": email,
        "Password": passw,
        'Verification': codiVeri,
      }
    ];

    return http.post(
      Uri.parse(urlToken + _path),
      body: jsonEncode(data)
    );
}





