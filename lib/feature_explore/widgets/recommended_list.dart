import 'package:flutter/material.dart';
import 'package:so_frontend/feature_event/screens/event_screen.dart';
import 'package:so_frontend/utils/air_tag.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:so_frontend/utils/like_button.dart';
import 'package:so_frontend/utils/share.dart';

class RecommendedList extends StatefulWidget {
  const RecommendedList({ Key? key }) : super(key: key);

  @override
  State<RecommendedList> createState() => _RecommendedListState();
}

class _RecommendedListState extends State<RecommendedList> {

  APICalls api = APICalls();

  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 280,
      child: FutureBuilder(
        future: api.getCollection('/v3/events/topten', [] , null),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var _recommendations = json.decode(snapshot.data.body);
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(width: 4),
              itemCount: _recommendations.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    width: 250,
                    height: 250,
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EventScreen(id: _recommendations[index]["id"]))
                            );
                          },
                          child: Container(
                            width: 250,
                            height: 180,
                            alignment: Alignment.topCenter,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white, 
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              child: SizedBox(
                                width: 250,
                                height: 180,
                                child: FittedBox(
                                  child: Image.network(_recommendations[index]["event_image_uri"],alignment: Alignment.topCenter),
                                  fit: BoxFit.cover
                                ),
                              ),
                            )
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 250,
                              height: 110,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                color: Theme.of(context).colorScheme.background,
                                boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, -3), // changes position of shadow
                                ),
                              ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  top: 8,
                                  bottom: 8,
                                  right:8
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(_recommendations[index]["date_creation"], style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 10),
                                    Text(_recommendations[index]["name"], style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 14, fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        AirTag(latitude: _recommendations[index]["latitude"].toString(), longitud: _recommendations[index]["longitud"].toString()),
                                        const Expanded(child: SizedBox()),
                                        IconButton(
                                          iconSize: 20,
                                          color: Theme.of(context).colorScheme.onSurface,
                                          icon: const Icon(Icons.share),
                                          onPressed: () => showShareMenu('https://socialout-develop.herokuapp.com/v3/events/' + _recommendations[index]["id"], context)
                                        ),
                                        const SizedBox(width: 10),
                                        LikeButton(id: _recommendations[index]["id"])
                                      ],
                                    )
                                  ]
                                ),
                              )
                            )
                          ],
                        )
                      ],
                    )
                  ),
                );
              },
            );
          }
          else {
            return const  Center(
              child: CircularProgressIndicator()
            );
          }
        } 
      ),
    );
  }
}