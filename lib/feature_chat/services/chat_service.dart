import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:so_frontend/utils/api_controller.dart';

class chatAPI {
  final String basicUrl = "https://socialout-develop.herokuapp.com/";

  /* Crear el chat */
  Future<http.Response> createChat(
    String eventId,
    String participantId,
  ) async {
    String _path = 'v1/chat/';
    //String partEvent = 'event_id='+eventId;
    //String partPartcipant = '&participant_id='+participantId;
    //String finalUri = basicUrl + _path+partEvent+partPartcipant;
    String finalUri = basicUrl + _path;
    var str = {
      "event_id": eventId,
      "participant_id": participantId,
    };
    final response = await http.post(Uri.parse(finalUri),
        body: jsonEncode(str), headers: {'Content-Type': 'application/json'});

    if (response.statusCode != 200) {
      // return error
    } else {}

    return response;
  }

  /* Get el todos los eventos en los que el usuario participa */
  Future<http.Response> getEvents(
    String participantId,
  ) async {
    String _path = 'v2/events/joined/';
    String finalUri = basicUrl + _path + participantId;

    final response = await http.get(Uri.parse(finalUri));

    if (response.statusCode != 200) {
      // return error
    } else {}

    return response;
  }

  /* entrar el chat */
  Future<http.Response> enterChat(
    String eventId,
    String participantId,
  ) async {
    String _path = 'v1/chat/';
    String partEvent = 'event_id=' + eventId;
    String partPartcipant = '&participant_id=' + participantId;
    String finalUri = basicUrl + _path + partEvent + partPartcipant;

    final response = await http.get(Uri.parse(finalUri));

    if (response.statusCode != 200) {
      // return error
    } else {}

    return response;
  }

  /* Crear el mensage */
  Future<http.Response> createMessage(
    String senderId,
    String chatId,
    String text,
  ) async {
    String _path = '/v1/chat/Message';
    String finalUri = basicUrl + _path;
    var str = {
      "participant_id": senderId,
      "event_id": chatId,
      "text": text,
    };

    final response =
        await http.post(Uri.parse(finalUri), body: jsonEncode(str), headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTY1Mzg0Njk4NywianRpIjoiYjdkYmU5OWUtMzE2Ny00MWM3LWE1ZjctMjJlM2IyNTE5ZThhIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6ImZlZTAzMzE5LTI3NDItNGVmNS04MzE3LTY3N2NiNjQ0NWVkYSIsIm5iZiI6MTY1Mzg0Njk4NywiZXhwIjoxNjUzODUwNTg3fQ.2XBjE2YDYlzoi4W3Oj7dWpiJt-E5UcDXk9nBP9CiTTc',
      'Content-Type': 'application/json'
    });

    return response;
  }

  /* Eliminar el mensage */
  Future<http.Response> deleteChat(
    String eventId,
  ) async {
    String _path = 'v1/chat/';
    String finalUri = basicUrl + _path;
    var str = {
      "event_id": eventId,
    };

    final response = await http.delete(Uri.parse(finalUri),
        body: jsonEncode(str), headers: {'Content-Type': 'application/json'});

    return response;
  }

  /* Eliminar el mensage */
  Future<http.Response> getListChat(
    String creatorId,
  ) async {
    String _path = 'v1/chat/';
    String finalUri = basicUrl + _path + creatorId;

    final response = await http.get(Uri.parse(finalUri));

    return response;
  }
}
