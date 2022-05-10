import 'package:flutter/material.dart';
import 'package:so_frontend/feature_event/widgets/event_map.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'dart:convert';

class Event extends StatefulWidget {
  final String id;
  const Event({ Key? key, required this.id}) : super(key: key);

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {

  List attendees = [{"image":"assets/dog.jpg"},{"image":"assets/dog.jpg"},{"image":"assets/dog.jpg"},{"image":"assets/dog.jpg"}];

  List _event = [{"id":'1', "title": "Gastronomic Route through El Born", "creator":"Mark", "date": "THURSDAY, 3 MAR · 17:00", "air_quality":"MODERATE", "description": 'Hello everybody! If you like chess as much as I do, you have to come to this open-air tournament in Tetuan square in Barcelona. There will be drinks and food until one of us wins. Don\'t miss this opportunity and sign up now!', "numAttendees": "17/20", "lat":21.0, "lng":0.0}];

  

  APICalls api = APICalls();


  Future<void> getEventById() async {

    

    final response = await api.getItem('/v2/events/', [widget.id]);
    if (response.statusCode < 300 && response.statusCode >= 200) {
      setState(() {
        _event = [];
        _event.add(json.decode(response.body));
      });
    
    }
  }

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
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
                      child: Image.asset('assets/event-big.png'),
                      fit: BoxFit.fitHeight
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
                          )
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
                              Text(_event[0]["title"], style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 20, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Created by: ' + _event[0]["creator"], style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w500)),
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
                                      Text(_event[0]["date"], style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w500)),
                                      const SizedBox(height: 15),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text('Air quality in this area:', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 14)),
                                          const Expanded(
                                            child: SizedBox()
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Theme.of(context).colorScheme.onError
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(_event[0]["air_quality"], style: TextStyle(color: Theme.of(context).colorScheme.background, fontSize: 14, fontWeight: FontWeight.bold)),
                                            )
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
                                      const SizedBox(height:20),
                                      EventMapButton(
                                        lat: _event[0]["lat"],
                                        lng: _event[0]["lng"]
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
          Container(
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
                Text(_event[0]["numAttendees"], style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w500, fontSize: 16)),
                const SizedBox(width: 30),
                Container(
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
                  
                )
              ],
            )
          )
        ],
      )
    );
  }
}