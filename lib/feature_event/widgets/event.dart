import 'package:flutter/material.dart';
import 'package:so_frontend/feature_event/widgets/event_map.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Event extends StatefulWidget {
  final String id;
  const Event({ Key? key, required this.id}) : super(key: key);

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {

  APICalls api = APICalls();

  bool found = false;

  Future<dynamic> joinEvent(String id, Map<String, dynamic> bodyData) async {

    final response = await api.postItem('/v2/events/:0/:1', [widget.id, 'join'], bodyData);
    return response;
  }

  Future<dynamic> leaveEvent(String id, Map<String, dynamic> bodyData) async {

    final response = await api.postItem('/v2/events/:0/:1', [widget.id, 'leave'], bodyData);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api.getItem('/v2/events/:0', [widget.id]),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          
          var _event = [json.decode(snapshot.data.body)];
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          child: FittedBox(
                            child: Image.network(_event[0]['event_image_uri']),
                            fit: BoxFit.cover
                          )
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 420,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  left: 16,
                                  right: 16,
                                  bottom: 16
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_event[0]["name"], style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 20, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        FutureBuilder(
                                          future: api.getItem("/v1/users/:0", [_event[0]["user_creator"]]),
                                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                                            if (snapshot.connectionState ==  ConnectionState.done) {
                                              var _user = [json.decode(snapshot.data.body)];
                                              return  Text('Created by: ' + _user[0]["username"], style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w500));
                                            }
                                            else {
                                              return const SizedBox(
                                                width: 25,
                                                height: 5,
                                                child: LinearProgressIndicator()
                                              );
                                            }
                                          }
                                        ),
                                        const SizedBox(width: 10),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).pushNamed('/profile');
                                          },
                                          child: SizedBox(
                                            width: 36,
                                            height: 36,
                                            child: ClipRRect(
                                              child: FittedBox(
                                                child: Image.asset('assets/dog.jpg'),
                                                fit: BoxFit.fitHeight
                                              ),
                                              borderRadius: BorderRadius.circular(100)
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    const Divider(),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 20),
                                            Text(_event[0]["date_started"], style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w500)),
                                            const SizedBox(height: 15),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text('Air quality in this area:', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 14)),
                                                const Expanded(
                                                  child: SizedBox()
                                                ),
                                                FutureBuilder(
                                                  future: http.get(Uri.parse('https://socialout-develop.herokuapp.com/v1/air/location?long=' +_event[0]["longitud"].toString()+ '&lat=' + _event[0]["latitude"].toString())),
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
                                            ),
                                            const SizedBox(height:20),
                                            const Divider(),
                                            const SizedBox(height:20),
                                            Text('Description', style: TextStyle(color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.bold, fontSize: 18)),
                                            const SizedBox(height: 10),
                                            Text(_event[0]["description"],
                                              style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface)
                                            ),
                                            const SizedBox(height: 20),
                                            const Divider(),
                                            const SizedBox(height: 20),
                                            Text('Attendees', style: TextStyle(color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.bold, fontSize: 18)),
                                            const SizedBox(height: 10),
                                            SizedBox(
                                              height: 80,
                                              width: MediaQuery.of(context).size.width,
                                              child: FutureBuilder(
                                                future: api.getCollection('/v2/events/participants',[],{"eventid":_event[0]["id"]}),
                                                builder: (BuildContext context, AsyncSnapshot snapshot) {
                                                  if (snapshot.connectionState == ConnectionState.done) {
                                                    var attendees = json.decode(snapshot.data.body);
                                                    return ListView.separated(
                                                      shrinkWrap: true,
                                                      scrollDirection: Axis.horizontal,
                                                      separatorBuilder: (context, index) => const SizedBox(width: 20),
                                                      itemCount: attendees.length,
                                                      itemBuilder: (BuildContext context, int index)  {
                                                        return InkWell(
                                                          onTap: () {
                                                            Navigator.of(context).pushNamed('/profile');
                                                          },
                                                            child: CircleAvatar(
                                                              radius: 40,
                                                              backgroundImage: NetworkImage(_event[0]['event_image_uri']),
                                                            )
                                                          );
                                                      }
                                                    );
                                                  }
                                                  else {
                                                    return const CircularProgressIndicator();
                                                  }
                                                } 
                                              )
                                            ),
                                            const SizedBox(height: 20),
                                            const Divider(),
                                            const SizedBox(height: 20),
                                            Text('Location', style: TextStyle(color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.bold, fontSize: 18)),
                                            const SizedBox(height:20),
                                            EventMapButton(
                                              lat: _event[0]["latitude"],
                                              lng: _event[0]["longitud"]
                                            ),
                                            const SizedBox(height:20)
        
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ),
                          ],
                        )
        
                      ]
                    )
                  )
                ),
                Material(
                  elevation: 15.0,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(top:BorderSide( width: 1.0, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)))
                    ),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, 
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 27,
                          color: Theme.of(context).colorScheme.secondary,
                          icon: const Icon(Icons.people),
                          onPressed: () {}
                        ),
                        FutureBuilder(
                          future: api.getCollection('/v2/events/participants', [], {"eventid":_event[0]["id"]}),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              var participants = json.decode(snapshot.data.body);
                              return Text(participants.length.toString() +"/" + _event[0]["max_participants"].toString(), style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w500, fontSize: 16));
                            } 
                            else {
                              return const CircularProgressIndicator();
                            }

                          }
                        ),
                        const SizedBox(width: 30),
                        FutureBuilder(
                          future: api.getCollection('/v2/events/participants',[],{"eventid":_event[0]["id"]}),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              var participants = json.decode(snapshot.data.body);
                              found = false;
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
                                      var response = await joinEvent(_event[0]["id"], bodyData);
                                      SnackBar snackBar;
                                      if (response.statusCode == 200) {
                                        snackBar = SnackBar(
                                          backgroundColor: Theme.of(context).colorScheme.secondary,
                                          content: const Text('You are in!'),
                                        );
                                      } else {
                                        snackBar = SnackBar(
                                          backgroundColor: Theme.of(context).colorScheme.error,
                                          content: const Text('Something bad happened. Try again later...'),
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
                                            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      width: 150,
                                      height: 40,
                                      child: Center(child: Text('JOIN NOW', style: TextStyle(color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.bold))),
                                    ),
                                  );
                              }
                              else {
                                return InkWell(
                                  onTap: () async {
                                    final bodyData = {"user_id": api.getCurrentUser()};
                                    var response = await leaveEvent(_event[0]["id"], bodyData);
                                    setState(() {
                                      found = false;
                                    });
                                    SnackBar snackBar;
                                      if (response.statusCode == 200) {
                                        snackBar = SnackBar(
                                          backgroundColor: Theme.of(context).colorScheme.secondary,
                                          content: const Text('You left!'),
                                        );
                                      } else {
                                        snackBar = SnackBar(
                                          backgroundColor: Theme.of(context).colorScheme.error,
                                          content: const Text('Something bad happened. Try again later...'),
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
                                          color: Theme.of(context).colorScheme.error.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    width: 150,
                                    height: 40,
                                    child: Center(child: Text('LEAVE', style: TextStyle(color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.bold))),
                                    
                                  ),
                                );
                              }
                              
                            }
                            else {
                              return const CircularProgressIndicator();
                            }
                          }
                        )
                      ],
                    )
                  ),
                )
              ],
            )
          );
        }
        else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}