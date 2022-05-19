import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:so_frontend/utils/api_controller.dart';
import 'package:so_frontend/utils/like_button.dart';

class JoinedList extends StatefulWidget {
  const JoinedList({ Key? key }) : super(key: key);

  @override
  State<JoinedList> createState() => _JoinedListState();
}

class _JoinedListState extends State<JoinedList> {

  
  APICalls api = APICalls();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder(
        future: api.getCollection('/v2/events/:0/:1', ['joined', api.getCurrentUser()], null),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var _joined = json.decode(snapshot.data.body);
            if (_joined.isEmpty) return const Center(child: Text('You have not joined any event!'));
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
                      Column(
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
                              FutureBuilder(
                                future: http.get(Uri.parse('https://socialout-develop.herokuapp.com/v1/air/location?long=' + _joined[index]["longitud"].toString()+ '&lat=' + _joined[index]["latitude"].toString())),
                                builder: (BuildContext context, AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==  ConnectionState.done) {
                                    var _airQuality = [json.decode(snapshot.data.body)];
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: _airQuality.isEmpty ? Theme.of(context).colorScheme.onSurface : _airQuality[0]["pollution"] < 0.15 ? Theme.of(context).colorScheme.secondary : _airQuality[0]["pollution"] < 0.3 ? Theme.of(context).colorScheme.onError : Theme.of(context).colorScheme.error,
                                        borderRadius: const BorderRadius.all(Radius.circular(25))
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: _airQuality.isEmpty ? Text("LOADING", style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.bold)) : _airQuality[0]["pollution"] < 0.15 ? Text("GOOD", style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.bold)) : _airQuality[0]["pollution"] < 0.3 ? Text("MODERATE", style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.bold)) : Text("BAD", style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.bold)), 
                                      ),
                                    );
                                  }
                                  else {
                                    return const CircularProgressIndicator();
                                  }
                                }
                              )
                            ]
                          )
          
                        ]
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
                                  onPressed: () {}),
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
