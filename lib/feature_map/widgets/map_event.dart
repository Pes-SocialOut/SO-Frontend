// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:so_frontend/utils/air_tag.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'dart:convert';
import 'package:so_frontend/utils/share.dart';
import 'package:so_frontend/utils/like_button.dart';

class EventWidget extends StatefulWidget {
  final Map<String, dynamic> event;
  final double pollution;
  const EventWidget({Key? key, required this.event, required this.pollution})
      : super(key: key);

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  var dateStyle = const TextStyle(
      color: Color.fromARGB(255, 18, 111, 187),
      decorationStyle: TextDecorationStyle.wavy,
      fontWeight: FontWeight.bold,
      fontSize: 20,
      height: 1.4);
  var eventStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 22,
      height: 1.4);
  var participantsStyle = const TextStyle(color: Colors.green, fontSize: 18);
  var explainStyle =
      const TextStyle(color: Color.fromARGB(255, 61, 60, 60), fontSize: 18);
  var creatorStyle =
      const TextStyle(color: Color.fromARGB(255, 17, 92, 153), fontSize: 20);
  bool isFavourite = false;

  // ignore: prefer_final_fields
  List _event = [
    {
      "id": '1',
      "title": "Gastronomic Route through El Born",
      "creator": "Mark",
      "date": "THURSDAY, 3 MAR · 17:00",
      "air_quality": "MODERATE",
      "description":
          'Hello everybody! If you like chess as much as I do, you have to come to this open-air tournament in Tetuan square in Barcelona. There will be drinks and food until one of us wins. Don\'t miss this opportunity and sign up now!',
      "numAttendees": "17/20"
    }
  ];

  APICalls api = APICalls();

  //Temporalmente hardcoded
  String eventPhoto = 'assets/gato.jpg';
  String creatorPhoto = 'assets/dog.jpg';

  Future<dynamic> joinEvent(String id, Map<String, dynamic> bodyData) async {
    final response = await api.postItem(
        '/v2/events/:0/:1', [widget.event["id"], 'join'], bodyData);
    return response;
  }

  Future<dynamic> leaveEvent(String id, Map<String, dynamic> bodyData) async {
    final response = await api.postItem(
        '/v2/events/:0/:1', [widget.event["id"], 'leave'], bodyData);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(children: [
        Row(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Column(children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.event["event_image_uri"]),
              ),
            ]),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(
                  child: Text(
                      widget.event["date_started"].substring(
                          0, widget.event["date_started"].length - 7),
                      style: dateStyle),
                ),
              ]),
              Row(children: [
                Expanded(
                  child: Text(widget.event["name"],
                      style: eventStyle, textAlign: TextAlign.left),
                ),
              ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AirTag(
                        longitud: widget.event["longitud"].toString(),
                        latitude: widget.event["latitude"].toString(),
                        id: widget.event["id"]),
                    Row(children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(children: [
                          const Icon(
                            Icons.person,
                            color: Colors.green,
                            size: 30.0,
                          ),
                          Text(widget.event["max_participants"].toString(),
                              style: participantsStyle)
                        ]),
                      ),
                    ]),
                  ])
            ]),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FutureBuilder(
              future: http.get(Uri.parse(
                  'https://socialout-develop.herokuapp.com/v1/users/' +
                      widget.event["user_creator"])),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  var user = json.decode(snapshot.data.body);
                  return Text(
                    'Createdby'.tr() + user["username"] + '  ',
                    style: creatorStyle,
                    textAlign: TextAlign.center,
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
          CircleAvatar(
            backgroundImage: AssetImage(creatorPhoto),
          )
        ]),
        const Divider(
            color: Color.fromARGB(255, 53, 52, 52),
            height: 30,
            indent: 30,
            endIndent: 30),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.event["description"],
              style: explainStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ]),
        const Divider(indent: 50, endIndent: 50),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          IconButton(
              icon: const Icon(Icons.share,
                  size: 30.0, color: Color.fromARGB(255, 110, 108, 108)),
              onPressed: () => showShareMenu(
                  'https://socialout-develop.herokuapp.com/v3/events/' +
                      widget.event["id"],
                  context)),
          const Divider(endIndent: 30),
          FutureBuilder(
              future: api.getCollection('/v2/events/participants', [],
                  {"eventid": widget.event["id"]}),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  var participants = json.decode(snapshot.data.body);
                  var found = false;
                  int i = 0;
                  while (!found && i < participants.length) {
                    if (participants[i] == api.getCurrentUser()) {
                      found = true;
                    }
                    ++i;
                  }
                  if (!found) {
                    return InkWell(
                      onTap: () async {
                        final bodyData = {"user_id": api.getCurrentUser()};
                        var response =
                            await joinEvent(_event[0]["id"], bodyData);
                        SnackBar snackBar;
                        if (response.statusCode == 200) {
                          snackBar = SnackBar(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            content: Text('Youarein'),
                          );
                        } else {
                          snackBar = SnackBar(
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                            content: Text('Somethingbadhappened').tr(),
                          );
                        }
                        setState(() {
                          found = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Theme.of(context).colorScheme.secondary,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        width: 150,
                        height: 40,
                        child: Center(
                            child: Text('JOINNOW',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        fontWeight: FontWeight.bold))
                                .tr()),
                      ),
                    );
                  } else {
                    return InkWell(
                      onTap: () async {
                        final bodyData = {"user_id": api.getCurrentUser()};
                        var response =
                            await leaveEvent(_event[0]["id"], bodyData);
                        setState(() {
                          found = false;
                        });
                        SnackBar snackBar;
                        if (response.statusCode == 200) {
                          snackBar = SnackBar(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            content: Text('Youleft').tr(),
                          );
                        } else {
                          snackBar = SnackBar(
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                            content: Text('Somethingbadhappened').tr(),
                          );
                        }
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Theme.of(context).colorScheme.error,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .error
                                  .withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        width: 150,
                        height: 40,
                        child: Center(
                            child: Text('LEAVE',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        fontWeight: FontWeight.bold))
                                .tr()),
                      ),
                    );
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              }),
          const Divider(indent: 30),
          LikeButton(id: widget.event["id"])
        ]),
      ]),
    );
  }
}
