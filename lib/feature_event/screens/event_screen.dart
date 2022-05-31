import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/feature_chat/screens/chat_screen.dart';
import 'package:so_frontend/feature_chat/screens/listChat_screen.dart';
import 'package:so_frontend/feature_event/widgets/event.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'package:so_frontend/utils/share.dart';
import 'package:so_frontend/utils/like_button.dart';
import 'package:http/http.dart' as http;

class EventScreen extends StatefulWidget {
  final String id;
  const EventScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  APICalls api = APICalls();
  String user_creator = "";
  Future<String> getEventCreator() async {
    http.Response resp = await getEventItem('/v2/events/:0', [widget.id]);
    var _event = [json.decode(resp.body)];
    user_creator = _event[0]["user_creator"];

    return user_creator;
  }

  Future<http.Response> getEventItem(
      String endpoint, List<String> pathParams) async {
    final uri = api.buildUri(endpoint, pathParams, null);
    final response = await http.get(uri, headers: {
      'Authorization': 'Bearer ' + APICalls().getCurrentAccess(),
      'Content-Type': 'application/json'
    });

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('Event',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 16))
                .tr(),
            backgroundColor: Theme.of(context).colorScheme.background,
            actions: <Widget>[
              IconButton(
                  iconSize: 24,
                  color: Theme.of(context).colorScheme.onSurface,
                  icon: const Icon(Icons.share),
                  onPressed: () => showShareMenu(
                      'https://socialout-develop.herokuapp.com/v3/events/' +
                          widget.id,
                      context)),
              LikeButton(id: widget.id),
              IconButton(
                iconSize: 24,
                color: Theme.of(context).colorScheme.onSurface,
                icon: const Icon(Icons.message),
                onPressed: () async {
                  String idEventCreator = await getEventCreator();
                  var acu = api.getCurrentUser();
                  bool aux = acu.compareTo(idEventCreator) == 0;
                  if (!aux) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                  eventId: widget.id,
                                  participanId: acu,
                                )));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListChatScreen(
                                  id_event: widget.id,
                                )));
                  }
                },
              )
            ],
            leading: IconButton(
              iconSize: 24,
              color: Theme.of(context).colorScheme.onSurface,
              icon: const Icon(Icons.arrow_back_ios_new_sharp),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: Center(child: Event(id: widget.id)));
  }
}
