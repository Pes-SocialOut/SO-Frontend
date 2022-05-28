import 'package:flutter/material.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'dart:convert';
import 'package:so_frontend/feature_event/screens/event_screen.dart';

class PastEventsList extends StatefulWidget {
  const PastEventsList({ Key? key }) : super(key: key);

  @override
  State<PastEventsList> createState() => _PastEventsListState();
}

class _PastEventsListState extends State<PastEventsList> {

  APICalls api = APICalls();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder(
        future: api.getCollection('/v2/events/:0/:1', ['like', api.getCurrentUser()], null),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var _joined = json.decode(snapshot.data.body);
            if (_joined.isEmpty) return const Center(child: Text('You have not liked any event!'));
            return ListView.separated(
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EventScreen(id: _joined[index]["id"]))
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_joined[index]["date_started"], style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 14, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 15),
                            Text(_joined[index]["name"], style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 16, fontWeight: FontWeight.w500)),
                            const SizedBox(height:15),
                          ]
                        ),
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
                                child: Image.network(_joined[index]["event_image_uri"]), 
                                fit: BoxFit.fitWidth
                              )
                            )
                          ),
                        ]
                      )
                    ],
                  ),
                );
              },
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