import 'package:flutter/material.dart';
import 'package:so_frontend/feature_event/widgets/event_map.dart';
import 'package:so_frontend/utils/air_tag.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'dart:convert';

class UserEvent extends StatefulWidget {
  final String id;
  const UserEvent({ Key? key, required this.id}) : super(key: key);

  @override
  State<UserEvent> createState() => _UserEventState();
}

class _UserEventState extends State<UserEvent> {

  List attendees = [{"image":"assets/dog.jpg"},{"image":"assets/dog.jpg"},{"image":"assets/dog.jpg"},{"image":"assets/dog.jpg"}];  

  APICalls api = APICalls();

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
                            child: Image.network(_event[0]["event_image_uri"]),
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
                                        // Text('Created by: ' + _event[0]["user_creator"], style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w500)),
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
                                                AirTag(id: _event[0]["id"], latitude: _event[0]["latitude"].toString(), longitud: _event[0]["longitud"].toString()),
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
                                              child: ListView.separated(
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
                                                        backgroundImage: AssetImage(attendees[index]["image"]),
                                                      )
                                                    );
                                                }
                                              )
                                            ),
                                            const SizedBox(height: 20),
                                            const Divider(),
                                            const SizedBox(height: 20),
                                            Text('Location', style: TextStyle(color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.bold, fontSize: 18)),
                                            const SizedBox(height: 20),
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
                  elevation: 100.0,
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
                        InkWell(
                          onTap: () async {
                            var response = await api.deleteItem('/v3/events/:0', [widget.id]);
                            var snackBar;
                              if (response.statusCode == 202) {
                                snackBar = SnackBar(
                                  backgroundColor: Theme.of(context).colorScheme.secondary,
                                  content: const Text('Your event has been created successfully!'),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                Navigator.pop(context);
                              } else if (response.statusCode == 400) {
                                snackBar = SnackBar(
                                  backgroundColor: Theme.of(context).colorScheme.error,
                                  content: Text('Bad Request! ' + json.decode(response.body)["error_message"]),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              } else {
                                snackBar = SnackBar(
                                  backgroundColor: Theme.of(context).colorScheme.error,
                                  content: const Text('Something went wrong! Try again later'),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            
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
                            child: Center(child: Text('DELETE', style: TextStyle(color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.bold))),
                            
                          ),
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
          return const Center(
            child: CircularProgressIndicator()
          );
        }
      } 
    );
  }
}