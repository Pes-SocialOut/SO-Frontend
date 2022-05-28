// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/feature_home/widgets/joined_list.dart';

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
              child: Column(children: [
                TabBar(
                    tabs: [Tab(text: 'Joined'.tr()), Tab(text: "Liked".tr())]),
                Expanded(
                  child: TabBarView(
                    children: [
                      const JoinedList(),
                      Container(color: Colors.red)
                    ],
                  ),
                )
              ]))),
    );
  }
}
