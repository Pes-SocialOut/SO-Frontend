// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class ExternServicePhoto {
  var baseUri = 'http://10.4.41.70:8080/Homies/services/external/';

  Future<dynamic> getAllPhotos() async {
    var path = 'getFotos';
    final uri = baseUri + path;
    var response = await http.get(Uri.parse(uri));
    return response;
  }

  Future<Map<String, dynamic>> postAPhoto(String idUser, String url) async {
    var path = 'postFoto';
    final uri = baseUri + path;
    var str = {"email": idUser, "URL": url};
    var response = await http.post(Uri.parse(uri),
        body: jsonEncode(str), headers: {'Content-Type': 'application/json'});
    return json.decode(response.body);
  }

  Future<String> getAPhoto(String idUser) async {
    String aux =
        "https://res.cloudinary.com/homies-image-control/image/upload/Fail";
    String retorno = "Fail";
    var path = 'getFoto/';
    final uri = baseUri + path + idUser;
    var response = await http.get(Uri.parse(uri));
    var mapa = json.decode(response.body);
    if (mapa['foto'] != aux) {
      retorno = mapa['foto'];
    }
    return retorno;
  }
}
