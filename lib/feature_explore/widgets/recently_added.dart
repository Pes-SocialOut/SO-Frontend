import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:so_frontend/utils/api_controller.dart';
import 'package:so_frontend/feature_event/screens/event_screen.dart';

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
                                          FutureBuilder(
                                            future: http.get(Uri.parse('https://socialout-develop.herokuapp.com/v1/air/location?long=' + recommendations[index]["longitud"].toString()+ '&lat=' + recommendations[index]["latitude"].toString())),
                                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                                              if (snapshot.connectionState == ConnectionState.done) {
                                                var _airQuality = [json.decode(snapshot.data.body)];
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    color:  _airQuality[0]["pollution"] < 0.15 ? Theme.of(context).colorScheme.secondary : _airQuality[0]["pollution"] < 0.3 ? Theme.of(context).colorScheme.onError : Theme.of(context).colorScheme.error,
                                                    borderRadius: const BorderRadius.all(Radius.circular(25))
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(2.0),
                                                    child:  _airQuality[0]["pollution"] < 0.15 ? Text("GOOD", style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.bold)) : _airQuality[0]["pollution"] < 0.3 ? Text("MODERATE", style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.bold)) : Text("BAD", style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.bold)), 
                                                  ),
                                                );
                                              }
                                              else {
                                                return const CircularProgressIndicator();
                                              }
                                            } 
                                          ),
                                          const Expanded(child: SizedBox()),
                                          IconButton(
                                            iconSize: 20,
                                            color: Theme.of(context).colorScheme.onSurface,
                                            icon: const Icon(Icons.share),
                                            onPressed: () {
                                              
                                            }
                                          ),
                                          const SizedBox(width: 10),
                                          IconButton(
                                            iconSize:20,
                                            color: Theme.of(context).colorScheme.onSurface,
                                            icon: const Icon(Icons.favorite),
                                            onPressed: () {
                          
                                            }
                                          )
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