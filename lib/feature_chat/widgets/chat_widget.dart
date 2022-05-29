import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/feature_chat/services/chat_service.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class SendWidget extends StatelessWidget {
  SendWidget({Key? key}) : super(key: key);
  final chatAPI cAPI = chatAPI();
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
              onPressed: () {
                APICalls api = APICalls();
                future:
                api.getCollection(
                    '/v2/events/:0/:1', ['joined', api.getCurrentUser()], null);
                String aux_s = APICalls().getCurrentUser();
                String accessToken = APICalls().getCurrentAccess();
                cAPI.getEvents(aux_s);
                print("accessToken:" + accessToken);

                //cAPI.createChat("23fa941a-9bee-4788-8b3d-3ebaa886bfe7","f01e9aaa-f0a9-42f0-98f3-0011f2c07d74");
                cAPI.createMessage(
                    "f01e9aaa-f0a9-42f0-98f3-0011f2c07d74",
                    "23fa941a-9bee-4788-8b3d-3ebaa886bfe7", //"23fa941a-9bee-4788-8b3d-3ebaa886bfe7",
                    "hola del f01e9aaa-f0a9-42f0-98f3-0011f2c07d74");
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
