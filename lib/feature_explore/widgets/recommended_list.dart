import 'package:flutter/material.dart';
import 'package:so_frontend/feature_event/screens/event_screen.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
        future: api.getCollection('/v2/events/', [] , null),
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
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EventScreen(id: _recommendations[index]["id"]))
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
                            height: 250,
                            alignment: Alignment.topCenter,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white, 
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              child: FittedBox(
                                child: Image.network(_recommendations[index]["event_image_uri"], width: 250, height: 250, alignment: Alignment.topCenter),
                                fit: BoxFit.fitHeight
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
                                          FutureBuilder(
                                            future: http.get(Uri.parse('https://socialout-develop.herokuapp.com/v1/air/location?long=' + _recommendations[index]["longitud"].toString()+ '&lat=' + _recommendations[index]["latitude"].toString())),
                                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                                              if (snapshot.connectionState == ConnectionState.done) {
                                                var _airQuality = [json.decode(snapshot.data.body)];
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    color: _airQuality[0]["pollution"] < 0.15 ? Theme.of(context).colorScheme.secondary : _airQuality[0]["pollution"] < 0.3 ? Theme.of(context).colorScheme.onError : Theme.of(context).colorScheme.error,
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