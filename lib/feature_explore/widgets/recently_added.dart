import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:so_frontend/utils/air_tag.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'package:so_frontend/feature_event/screens/event_screen.dart';
import 'package:so_frontend/utils/like_button.dart';
import 'package:so_frontend/utils/share.dart';

class RecentlyAdded extends StatefulWidget {
  const RecentlyAdded({ Key? key }) : super(key: key);

  @override
  State<RecentlyAdded> createState() => _RecentlyAddedState();
}

class _RecentlyAddedState extends State<RecentlyAdded> {

  List recommendations = [{"name": "Running training in Collserola", "date":"THU, 3 MAR · 17:00", "air":"GOOD", "image":"assets/event2-preview.png"}, {"name": "Running training in Collserola", "date":"THU, 3 MAR · 17:00", "air":"GOOD", "image":"assets/event2-preview.png"}, {"name": "Running training in Collserola", "date":"THU, 3 MAR · 17:00", "air":"GOOD", "image":"assets/event2-preview.png"}, {"name": "Running training in Collserola", "date":"THU, 3 MAR · 17:00", "air":"GOOD", "image":"assets/event2-preview.png"}, {"name": "Running training in Collserola", "date":"THU, 3 MAR · 17:00", "air":"GOOD", "image":"assets/event2-preview.png"}, {"name": "Running training in Collserola", "date":"THU, 3 MAR · 17:00", "air":"GOOD", "image":"assets/event2-preview.png"}];

  APICalls api = APICalls();

  final String pathParam = "lastten";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api.getCollection('/v2/events/:0', [pathParam], null),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var recommendations = json.decode(snapshot.data.body);
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 280,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(width: 4),
              itemCount: recommendations.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EventScreen(id: recommendations[index]["id"]))
                      );
                    },
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
                          Container(
                            width: 250,
                            height: 180,
                            alignment: Alignment.topCenter,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white, 
                            ),
                            child: SizedBox(
                              width: 250,
                              height: 180,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                child: FittedBox(
                                  child: Image.network(recommendations[index]["event_image_uri"], alignment: Alignment.topCenter),
                                  fit: BoxFit.cover
                                ),
                              ),
                            )
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 250,
                                height: 110,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  color: Theme.of(context).colorScheme.background
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 12,
                                    top: 8,
                                    bottom: 8,
                                    right:12
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(recommendations[index]["date_started"], style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 10),
                                      Text(recommendations[index]["name"], style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 14, fontWeight: FontWeight.bold)),
                                      Row(
                                        children: [
                                          AirTag(id: recommendations[index]["id"], latitude: recommendations[index]["latitude"].toString(), longitud: recommendations[index]["longitud"].toString()),
                                          const Expanded(child: SizedBox()),
                                          IconButton(
                                            iconSize: 20,
                                            color: Theme.of(context).colorScheme.onSurface,
                                            icon: const Icon(Icons.share),
                                            onPressed: () => showShareMenu('https://socialout-develop.herokuapp.com/v3/events/' + recommendations[index]["id"], context)
                                          ),
                                          const SizedBox(width: 10),
                                          LikeButton(id: recommendations[index]["id"])
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
                  ),
                );
              },
            ),
          );
        }
        else {
          return const SizedBox(
            height: 280,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
      }
      
    );
  }
}