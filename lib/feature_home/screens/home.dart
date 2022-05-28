import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/feature_home/widgets/user_events.dart';
import 'package:so_frontend/feature_home/widgets/events_tab_menu.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Myevents',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontWeight: FontWeight.bold,
                      fontSize: 18))
              .tr(),
          const SizedBox(height: 20),
          const UserEventsList(),
          const SizedBox(height: 20),
          Text('Yourcalendar',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontWeight: FontWeight.bold,
                      fontSize: 18))
              .tr(),
          const SizedBox(height: 20),
          const EventsTabMenu()
        ],
      ),
    );
  }
}
