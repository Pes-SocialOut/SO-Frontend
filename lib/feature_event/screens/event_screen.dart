import 'package:flutter/material.dart';
import 'package:so_frontend/feature_event/widgets/event.dart';

class EventScreen extends StatelessWidget {
  final String id;
  const EventScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('Event',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 16)),
            backgroundColor: Theme.of(context).colorScheme.background,
            actions: <Widget>[
              IconButton(
                  iconSize: 24,
                  color: Theme.of(context).colorScheme.onSurface,
                  icon: const Icon(Icons.share),
                  onPressed: () {}),
              IconButton(
                  iconSize: 24,
                  color: Theme.of(context).colorScheme.onSurface,
                  icon: const Icon(Icons.favorite),
                  onPressed: () {}),
            ],
            leading: IconButton(
              iconSize: 24,
              color: Theme.of(context).colorScheme.onSurface,
              icon: const Icon(Icons.arrow_back_ios_new_sharp),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body:  Center(child: Event(id: id)));
  }
}
