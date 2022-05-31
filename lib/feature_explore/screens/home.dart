// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/feature_explore/widgets/map_button.dart';
import 'package:so_frontend/feature_explore/widgets/recommended_list.dart';
import 'package:so_frontend/feature_explore/widgets/recently_added.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Searchevents',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ).tr(),
            const SizedBox(height: 10),
            const MapButton(),
            const SizedBox(height: 30),
            Text('Recommendedyou',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.surface))
                .tr(),
            const SizedBox(height: 10),
            const RecommendedList(),
            const SizedBox(height: 30),
            Text('Recentlycreateusers',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.surface))
                .tr(),
            const SizedBox(height: 10),
            const RecentlyAdded()
          ],
        ),
      ),
    );
  }
}
