import 'package:flutter/material.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'package:so_frontend/utils/like_button.dart';
import 'dart:convert';
import 'package:so_frontend/feature_event/screens/event_screen.dart';
import 'package:so_frontend/utils/share.dart';
import 'package:so_frontend/utils/air_tag.dart';

class LikedList extends StatefulWidget {
  const LikedList({ Key? key }) : super(key: key);

  @override
  State<LikedList> createState() => _LikedListState();
}

class _LikedListState extends State<LikedList> {

  APICalls api = APICalls();


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder(
        future: api.getCollection('/v3/events/:0/:1', ['like', api.getCurrentUser()], null),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var _joined = json.decode(snapshot.data.body);
            if (_joined.isEmpty) return const Center(child: Text('You have not liked any event!'));
            return ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: _joined.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 130,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EventScreen(id: _joined[index]["id"]))
                            );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_joined[index]["date_started"], style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 15),
                            Text(_joined[index]["name"], style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 16, fontWeight: FontWeight.w500)),
                            const SizedBox(height:15),
                            Row(
                              children: [
                                FutureBuilder(
                                  future: api.getCollection('/v2/events/participants', [], {"eventid":_joined[index]["id"]}),
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      var participants = json.decode(snapshot.data.body);
                                      return Text(participants.length.toString() + " are going", style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w500, fontSize: 14));
                                    } 
                                    else {
                                      return const CircularProgressIndicator();
                                    }
                      
                                  }
                                ),
                                const SizedBox(width: 20),
                                AirTag(id: _joined[index]["id"], latitude: _joined[index]["latitude"].toString(), longitud: _joined[index]["longitud"].toString()),
                              ]
                            )
                                
                          ]
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 72,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              child: FittedBox(
                                child: Image.network(_joined[index]["event_image_uri"]), 
                                fit: BoxFit.fitWidth
                              )
                            )
                          ),
                          Row(
                            children: [
                              IconButton(
                                  iconSize: 20,
                                  color: Theme.of(context).colorScheme.onSurface,
                                  icon: const Icon(Icons.share),
                                  onPressed: () => showShareMenu('https://socialout-develop.herokuapp.com/v3/events/' + _joined[index]["id"], context)),
                              const SizedBox(width: 10),
                              LikeButton(id: _joined[index]["id"])
                            ],
                          )
                        ]
                      )
                    ],
                  ),
                );
              },
            );
          }
          else {
            return const Center(
              child: CircularProgressIndicator()
            );
          }
        } 
      ),
    );
  }
}