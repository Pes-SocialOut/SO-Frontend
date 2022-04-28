import 'package:flutter/material.dart';
import 'package:so_frontend/feature_home/widgets/user_events.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:   [
            Text('My events', style: TextStyle(color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 20),
            const UserEventsList()
          ],
        ),
    );
  }
}