import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:so_frontend/feature_chat/services/chat_service.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class SendWidget extends StatelessWidget {
  final String eventId;
  SendWidget({Key? key, required this.eventId}) : super(key: key);
  //= "f6a92275-7e03-4d3c-a152-2247e68dd047";
  final chatAPI cAPI = chatAPI();
  final messageTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
        height: 60,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: TextField(
                controller: messageTextController,
                decoration: InputDecoration(
                    hintText: "Write message...",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            FloatingActionButton(
              onPressed: () async {
                APICalls api = APICalls();

                String currentUserId = APICalls().getCurrentUser();
                String accessToken = APICalls().getCurrentAccess();
                cAPI.getEvents(currentUserId);

                print("accessToken:" + accessToken);
                print(messageTextController.text);

                Response resp = await cAPI.createMessage(
                    currentUserId,
                    eventId, //"23fa941a-9bee-4788-8b3d-3ebaa886bfe7",
                    messageTextController.text);
                messageTextController.clear();

                /*
                //ejecutar cuando unir un participante
                Response resp = await cAPI.createChat(
                    "eventId", currentUserId);
          */
                /*
                cAPI.createMessage(
                    "b4fa64c9-cfda-4c92-91d0-ac5dad48a83f",
                    eventId, //"23fa941a-9bee-4788-8b3d-3ebaa886bfe7",
                    "hola del f01e9aaa-f0a9-42f0-98f3-0011f2c07d74");
                    */
                /*
                cAPI.enterChat(eventId,
                    "b4fa64c9-cfda-4c92-91d0-ac5dad48a83f");
                */
                /*
                cAPI.openSession(eventId,
                    "b4fa64c9-cfda-4c92-91d0-ac5dad48a83f");
                 */
                /*
                cAPI.getListChat("fee03319-2742-4ef5-8317-677cb6445eda");
                */
                String a = '0';
              },
              child: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.primary,
                size: 18,
              ),
              backgroundColor: Colors.blue,
              elevation: 0,
            ),
          ],
        ),
      ),
    );
  }
}
