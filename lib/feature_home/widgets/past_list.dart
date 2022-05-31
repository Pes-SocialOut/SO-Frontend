// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'dart:convert';
import 'package:so_frontend/feature_event/screens/event_screen.dart';
import 'package:so_frontend/utils/review.dart';
import 'package:skeletons/skeletons.dart';

class PastEventsList extends StatefulWidget {
  const PastEventsList({Key? key}) : super(key: key);

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
          future: api.getCollection('/v3/events/:0', ['pastevents'],
              {"userid": api.getCurrentUser()}),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var _joined = json.decode(snapshot.data.body);
              if (_joined.isEmpty) {
                return Center(child: Text('reviewedevent').tr());
              }
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
                          onTap: () =>
                              showReviewMenu(_joined[index]["id"], context),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    _joined[index]["date_started"].substring(
                                        0,
                                        _joined[index]["date_started"].length -
                                            7),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(height: 15),
                                Text(_joined[index]["name"],
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(height: 15),
                              ]),
                        ),
                        const Expanded(child: SizedBox()),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 120,
                                  height: 72,
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      child: FittedBox(
                                          child: Image.network(_joined[index]
                                              ["event_image_uri"]),
                                          fit: BoxFit.fitWidth))),
                            ])
                      ],
                    ),
                  );
                },
              );
            } else {
              return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 20),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: SkeletonItem(
                          child: SkeletonParagraph(
                              style: SkeletonParagraphStyle(
                                  lines: 1,
                                  spacing: 4,
                                  lineStyle: SkeletonLineStyle(
                                      width: MediaQuery.of(context).size.width,
                                      height: 130,
                                      borderRadius:
                                          BorderRadius.circular(10))))),
                    );
                  });
            }
          }),
    );
  }
}
