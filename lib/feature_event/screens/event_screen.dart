import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  final String id;
  const EventScreen({ Key? key, required this.id }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event')
      ),
      body: Center(
        child: Text('Event aquí ' + this.id)
      )
    );
  }
}