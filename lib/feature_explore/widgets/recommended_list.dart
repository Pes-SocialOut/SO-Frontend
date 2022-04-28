import 'package:flutter/material.dart';
import 'package:so_frontend/feature_event/screens/event_screen.dart';

class RecommendedList extends StatefulWidget {
  const RecommendedList({ Key? key }) : super(key: key);

  @override
  State<RecommendedList> createState() => _RecommendedListState();
}

class _RecommendedListState extends State<RecommendedList> {

  List recommendations = [{"name": "Gastronomic Route through El Born", "date":"THU, 3 MAR · 17:00", "air":"MODERATE", "image":"assets/event-preview.png"},{"name": "Gastronomic Route through El Born", "date":"THU, 3 MAR · 17:00", "air":"MODERATE", "image":"assets/event-preview.png"},{"name": "Gastronomic Route through El Born", "date":"THU, 3 MAR · 17:00", "air":"MODERATE", "image":"assets/event-preview.png"},{"name": "Gastronomic Route through El Born", "date":"THU, 3 MAR · 17:00", "air":"MODERATE", "image":"assets/event-preview.png"},{"name": "Gastronomic Route through El Born", "date":"THU, 3 MAR · 17:00", "air":"MODERATE", "image":"assets/event-preview.png"}, ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  MaterialPageRoute(builder: (context) => const EventScreen(id: '0'))
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
                    Image.asset(recommendations[index]["image"]),
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
                              left: 8,
                              top: 8,
                              bottom: 8,
                              right:8
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(recommendations[index]["date"], style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                Text(recommendations[index]["name"], style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 14, fontWeight: FontWeight.bold)),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.onError,
                                        borderRadius: const BorderRadius.all(Radius.circular(25))
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(recommendations[index]["air"], style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.bold)),
                                      ),
                                      
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
}