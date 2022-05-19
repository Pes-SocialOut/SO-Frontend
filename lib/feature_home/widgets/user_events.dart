import 'package:flutter/material.dart';
import 'package:so_frontend/feature_event/screens/user_event_screen.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'dart:convert';

class UserEventsList extends StatefulWidget {
  const UserEventsList({Key? key}) : super(key: key);

  @override
  State<UserEventsList> createState() => _UserEventsListState();
}

class _UserEventsListState extends State<UserEventsList> {
  
  APICalls api = APICalls();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 140,
        child: FutureBuilder(
          future: api.getCollection('/v2/events/:0', ["creator"], {"userid":api.getCurrentUser()}),
          builder: (BuildContext context, AsyncSnapshot snapshot)  {
            if (snapshot.connectionState == ConnectionState.done) {
              var _events = json.decode(snapshot.data.body);
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                separatorBuilder: (context, index) => const SizedBox(width: 20),
                itemCount: _events.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) =>  UserEventScreen(id: _events[index]["id"]))
                        );
                    },
                    child: Center(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          width: 100,
                          height: 115,
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 115,
                                width: 100,
                                child: ClipRRect(
                                  child: FittedBox(child: Image.network(_events[index]["event_image_uri"]), fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                              Container(
                                height: 115,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.black
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter
                                  )
                                ),
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 4.0,
                                    left: 4.0,
                                    bottom: 6.0,
                                    right: 4.0
                                  ),
                                  child: Text(_events[index]["name"], style: TextStyle(color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.bold))
                                )
                              )
                            ],
                          ),
                        ),
                    ),
                  );
                }
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
