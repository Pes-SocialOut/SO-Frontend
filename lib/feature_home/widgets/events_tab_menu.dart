// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/feature_home/widgets/joined_list.dart';
import 'package:so_frontend/feature_home/widgets/liked_list.dart';

class EventsTabMenu extends StatefulWidget {
  const EventsTabMenu({Key? key}) : super(key: key);

  @override
  State<EventsTabMenu> createState() => _EventsTabMenuState();
}

class _EventsTabMenuState extends State<EventsTabMenu> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: DefaultTabController(
              length: 2,
              child: Column(children: const [
                TabBar(tabs: [Tab(text: 'JOINED'), Tab(text: "LIKED")]),
                Expanded(
                  child: TabBarView(
                    children: [
                      JoinedList(),
                      LikedList(),
                    ],
                  ),
                )
              ]))),
    );
  }
}
