import 'package:flutter/material.dart';
import 'package:so_frontend/feature_event/screens/event_screen.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EventScreen(id: 'Guillem'))
                );
              },
              child: Container(
                decoration: const BoxDecoration(color: Colors.grey),
                child: const Center(child: Text('Esto es un evento')),
                width: 200,
                height: 80,
              )
            )
          ],
        ),
    );
  }
}