import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:so_frontend/utils/like_button.dart';

class EventWidget extends StatefulWidget {
  final Map<String, dynamic> event;
  final double pollution;
  const EventWidget({Key? key, required this.event, required this.pollution}) : super(key: key);

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

  //Temporalmente hardcoded
  String eventPhoto = 'assets/gato.jpg';
  String creatorPhoto = 'assets/dog.jpg';

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
                  child: Text(widget.event["date_started"], style: dateStyle),
                ),
              ]),
              Row(children: [
                Expanded(
                  child: Text(widget.event["name"],
                      style: eventStyle, textAlign: TextAlign.left),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                  Widget>[
                ElevatedButton(
                  child: Text(_event[0]["air_quality"]),
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: (_event[0]["air_quality"] == 'MODERATE')
                          ? const Color.fromARGB(255, 230, 217, 106)
                          : (_event[0]["air_quality"] == 'LOW')
                              ? Colors.green
                              : Colors.red),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: (_event[0]["air_quality"] == 'MODERATE')
                                    ? const Text('Contaminación moderada')
                                    : (_event[0]["air_quality"] == 'LOW')
                                        ? const Text('Contaminación baja')
                                        : const Text('Contaminación alta'),
                                content: (_event[0]["air_quality"] ==
                                        'MODERATE')
                                    ? const Text(
                                        'Se espera que para la fecha y hora indicados en el evento la polución sea moderada. Los contaminantes predominantes son los siguientes:')
                                    : (_event[0]["air_quality"] == 'LOW')
                                        ? const Text(
                                            'Se espera que para la fecha y hora indicados en el evento la polución sea baja. Los contaminantes predominantes son los siguientes:')
                                        : const Text(
                                            'Se espera que para la fecha y hora indicados en el evento la polución sea alta. Los contaminantes predominantes son los siguientes:'),
                                actions: [
                                  TextButton(
                                    child: const Text('Aceptar'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ]));
                  },
                ),
                Row(children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(children: [
                      const Icon(
                        Icons.person,
                        color: Colors.green,
                        size: 30.0,
                      ),
                      Text(widget.event["max_participants"].toString(), style: participantsStyle)
                    ]),
                  ),
                ]),
              ])
            ]),
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FutureBuilder(
            future: http.get(Uri.parse('https://socialout-develop.herokuapp.com/v1/users/' + widget.event["user_creator"])),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var user = json.decode(snapshot.data.body);
                return Text(
                  'Created by: ' + user["username"] + '  ',
                  style: creatorStyle,
                  textAlign: TextAlign.center,
                );
              }
              else {
                return const CircularProgressIndicator();
              }
            } 
          ),
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
              onPressed: () {}),
          const Divider(endIndent: 30),
          ElevatedButton(
            child: const Text('    JOIN NOW    '),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.green,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                          title: const Text('Joined!'),
                          content: const Text(
                              'You have joined the event! Now you will recieve notifications about it.\nYou can change this on settings.'),
                          actions: [
                            TextButton(
                              child: const Text('Aceptar'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ]));
            },
          ),
          const Divider(indent: 30),
          LikeButton(id: widget.event["id"])
          // IconButton(
          //     icon: Icon(Icons.favorite,
          //         size: 30.0,
          //         color: (isFavourite == true)
          //             ? Colors.red
          //             : const Color.fromARGB(255, 114, 113, 113)),
          //     onPressed: () {
          //       setState(() {
          //         isFavourite = !isFavourite;
          //       });
          //     })
        ]),
      ]),
    );
  }
}
