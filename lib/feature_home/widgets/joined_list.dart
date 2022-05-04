import 'package:flutter/material.dart';

class JoinedList extends StatefulWidget {
  const JoinedList({ Key? key }) : super(key: key);

  @override
  State<JoinedList> createState() => _JoinedListState();
}

class _JoinedListState extends State<JoinedList> {

  List _joined = [{"name": "Running training in Collserola", "date":"THU, 3 MAR · 17:00", "air":"GOOD", "image":"assets/joined-event.png", "attendees":"20"}, {"name": "Running training in Collserola", "date":"THU, 3 MAR · 17:00", "air":"GOOD", "image":"assets/joined-event.png", "attendees":"20"}, {"name": "Running training in Collserola", "date":"THU, 3 MAR · 17:00", "air":"GOOD", "image":"assets/joined-event.png", "attendees":"20"}, {"name": "Running training in Collserola", "date":"THU, 3 MAR · 17:00", "air":"GOOD", "image":"assets/joined-event.png", "attendees":"20"}, {"name": "Running training in Collserola", "date":"THU, 3 MAR · 17:00", "air":"GOOD", "image":"assets/joined-event.png", "attendees":"20"}, {"name": "Running training in Collserola", "date":"THU, 3 MAR · 17:00", "air":"GOOD", "image":"assets/joined-event.png", "attendees":"20"}];
  
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: _joined.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 130,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_joined[index]["date"], style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 15),
                        Text(_joined[index]["name"], style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 16, fontWeight: FontWeight.w500)),
                        const SizedBox(height:15),
                        Row(
                          children: [
                            Text(_joined[index]["attendees"] + ' people going', style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 14)),
                            const SizedBox(width: 20),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Theme.of(context).colorScheme.secondary
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(_joined[index]["air"], style: TextStyle(color: Theme.of(context).colorScheme.background, fontSize: 14, fontWeight: FontWeight.bold)),
                              )
                            )
                          ]
                        )

                      ]
                    ),
                    const Expanded(child: SizedBox()),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 72,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            child: FittedBox(
                              child: Image.asset(_joined[index]["image"]), 
                              fit: BoxFit.fitWidth
                            )
                          )
                        ),
                        Row(
                          children: [
                            IconButton(
                                iconSize: 24,
                                color: Theme.of(context).colorScheme.onSurface,
                                icon: const Icon(Icons.share),
                                onPressed: () {}),
                            const SizedBox(width: 10),
                            IconButton(
                                iconSize: 24,
                                color: Theme.of(context).colorScheme.onSurface,
                                icon: const Icon(Icons.favorite),
                                onPressed: () {}),
                          ],
                        )
                      ]
                    )
                  ],
                ),
              );
            },
          ),
        )
      )
    );
  }
}
