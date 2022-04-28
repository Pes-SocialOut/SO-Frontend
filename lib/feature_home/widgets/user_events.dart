import 'package:flutter/material.dart';

class UserEventsList extends StatefulWidget {
  const UserEventsList({Key? key}) : super(key: key);

  @override
  State<UserEventsList> createState() => _UserEventsListState();
}

class _UserEventsListState extends State<UserEventsList> {
  final List _events = [
    {"name": "Padel 2x2 Tournament", "image": "assets/dog.jpg"},
    {"name": "Padel 2x2 Tournament", "image": "assets/dog.jpg"},
    {"name": "Padel 2x2 Tournament", "image": "assets/dog.jpg"},
    {"name": "Padel 2x2 Tournament", "image": "assets/dog.jpg"}
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 140,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemCount: _events.length,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: Container(
                    margin: const EdgeInsets.only(right: 8.0),
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
                    child: Stack(children: [
                      SizedBox(
                        width: 100,
                        height: 115,
                        child: FittedBox(
                            child: Image.asset(_events[index]["image"]),
                            fit: BoxFit.fill),
                      )
                    ])),
              );
            }));
  }
}
