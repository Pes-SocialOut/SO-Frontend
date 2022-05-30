// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class ExternServicePhoto {
  var baseUri = 'http://10.4.41.70:8080/Homies/services/external/';

  Future<dynamic> getAllPhotos() async {
    print("INICIO GET INFO");
    var path = 'getFotos';
    final uri = baseUri + path;
    print(uri);
    var response = await http.get(Uri.parse(uri));
    print("REALIZO LA LLAMADA GET INFO");
    //print(json.decode(response.body).toString());
    List<dynamic> resultado = json.decode(response.body);
    print(resultado.length.toString());
    print("FINAL GET INFO");
    print(resultado.toString());
    return response;
  }

  Future<Map<String, dynamic>> postAPhoto(String idUser, String url) async {
    print("INICIO POST FOTO");
    var path = 'postFoto';
    final uri = baseUri + path;
    var str = {"email": idUser, "URL": url};
    print(uri);
    var response = await http.post(Uri.parse(uri),
        body: jsonEncode(str), headers: {'Content-Type': 'application/json'});
    print("REALIZO LA LLAMADA POST FOTO");
    print(json.decode(response.body).toString());

    print("FINAL POST FOTO");
    return json.decode(response.body);
  }

  Future<String> getAPhoto(String idUser) async {
    print("INICIO GET  A PHOTO");
    String aux =
        "https://res.cloudinary.com/homies-image-control/image/upload/Fail";
    String retorno = "Fail";
    var path = 'getFoto/';
    final uri = baseUri + path + idUser;
    print(uri);
    var response = await http.get(Uri.parse(uri));
    print("REALIZO LA LLAMADA UNA FOTO");
    print(json.decode(response.body).toString());
    var mapa = json.decode(response.body);
    if (mapa['foto'] != aux) {
      retorno = mapa['foto'];
    }
    print("FINAL GET A FOTO");
    return retorno;
  }
}
