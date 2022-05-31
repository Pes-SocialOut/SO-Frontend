import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:so_frontend/feature_chat/models/chat_model.dart';
import 'package:so_frontend/feature_chat/models/message_model.dart';
import 'package:so_frontend/feature_chat/screens/chat_screen.dart';
import 'package:so_frontend/feature_chat/services/chat_service.dart';
import 'package:so_frontend/feature_chat/widgets/chat_widget.dart';
import 'package:so_frontend/feature_event/screens/edit_event_screen.dart';
import 'package:so_frontend/feature_user/services/login_signUp.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'package:so_frontend/feature_user/services/externalService.dart';

class ListChatScreen extends StatefulWidget {
  final String id_event;
  const ListChatScreen({Key? key, required this.id_event}) : super(key: key);
  @override
  State<ListChatScreen> createState() => _ListChatScreen();
}

class _ListChatScreen extends State<ListChatScreen> {
  final chatAPI cAPI = chatAPI();
  final ExternServicePhoto espApi = ExternServicePhoto();
  final APICalls api = APICalls();
  Map user = {};
  void getListChat() {
    cAPI.getListChat(APICalls().getCurrentUser());
  }

  void setListChat() {
    getListChat();
  }

  @override
  void initState() {
    //initUser();
    // TODO: implement initState
    setListChat();
    //getEventName().then((value) => print("value: " + value));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        //future: api.getItem('/v2/events/:0', [eventId]),

        future: cAPI.getListChat(APICalls().getCurrentUser()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var chats = json.decode(snapshot.data.body);
            List<Chat> listChats =
                List<Chat>.from(chats.map((data) => Chat.fromJson(data)));
            listChats = listChats.reversed.toList();
            listChats = listChats
                .where((element) =>
                    element.participant_id != APICalls().getCurrentUser())
                .toList();
            return Scaffold(
              appBar: AppBar(
                  centerTitle: true,
                  title: Text('Event',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                          fontSize: 16)),
                  backgroundColor: Theme.of(context).colorScheme.background,
                  leading: IconButton(
                    iconSize: 24,
                    color: Theme.of(context).colorScheme.onSurface,
                    icon: const Icon(Icons.arrow_back_ios_new_sharp),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
              body: Container(
                  child: Stack(children: [
                Container(
                    child: ListView.builder(
                        reverse: true,
                        itemCount: listChats.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10),
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          //String uriPhoro = await espApi.getAPhoto(listChats[index].participant_id);
                          return FutureBuilder(
                              future: api.getItem('v2/users/:0',
                                  [listChats[index].participant_id]),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  user = json.decode(snapshot.data.body);
                                  print("${user["username"]}");
                                  return Card(
                                      clipBehavior: Clip.antiAlias,
                                      child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          onTap: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChatScreen(
                                                          eventId:
                                                              widget.id_event,
                                                          participanId:
                                                              listChats[index]
                                                                  .participant_id,
                                                        )));
                                          },
                                          child: Ink(
                                              height: 50,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              padding: EdgeInsets.only(
                                                  left: 16, top: 10),
                                              child: Text(
                                                "${user["username"]}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground,
                                                    fontSize: 20),
                                              ))));
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              });
                        }))
              ])),
            );
          } else {
            return Center(
                child: SizedBox(
              child: CircularProgressIndicator(),
              height: 30.0,
              width: 30.0,
            ));
          }
        });
  }
}
