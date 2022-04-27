import 'package:flutter/material.dart';

class RecommendedList extends StatefulWidget {
  const RecommendedList({ Key? key }) : super(key: key);

  @override
  State<RecommendedList> createState() => _RecommendedListState();
}

class _RecommendedListState extends State<RecommendedList> {

  List recommendations = [{"name": "Gastronomic Route through El Born", "date":"THU, 3 MAR · 17:00", "air":"MODERATE"}, {"name": "Gastronomic Route through El Born", "date":"THU, 3 MAR · 17:00", "air":"MODERATE"}, {"name": "Gastronomic Route through El Born", "date":"THU, 3 MAR · 17:00", "air":"MODERATE"}, {"name": "Gastronomic Route through El Born", "date":"THU, 3 MAR · 17:00", "air":"MODERATE"}];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        separatorBuilder: (context, index) => const SizedBox(width: 20),
        itemCount: recommendations.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 250,
            height: 250,
            child: Stack(
              children: [
                Image.asset('assets/event-preview.png'),
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
          );
        },
      ),
    );
  }
}