import 'package:flutter/material.dart';
import 'package:so_frontend/feature_event/widgets/user_event.dart';
import 'package:so_frontend/feature_event/screens/edit_event_screen.dart';

class UserEventScreen extends StatelessWidget {
  final String id; 
  const UserEventScreen({ Key? key, required this.id }) : super(key: key);

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
              icon: const Icon(Icons.create_sharp),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  EditEventScreen(id: id))
                );
              }),
          
        ],
        leading: IconButton(
          iconSize: 24,
          color: Theme.of(context).colorScheme.onSurface,
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ),
      body: const Center(child: UserEvent())
    );
  }
}