import 'package:flutter/material.dart';
import 'package:so_frontend/feature_chat/screens/chat_screen.dart';
import 'package:so_frontend/feature_event/widgets/event.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'package:so_frontend/utils/share.dart';
import 'package:so_frontend/utils/like_button.dart';

class EventScreen extends StatefulWidget {
  final String id;
  const EventScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  APICalls api = APICalls();

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
                  onPressed: () => showShareMenu(
                      'https://socialout-develop.herokuapp.com/v3/events/' +
                          widget.id,
                      context)),
              LikeButton(id: widget.id),
            ],
            leading: IconButton(
              iconSize: 24,
              color: Theme.of(context).colorScheme.onSurface,
              icon: const Icon(Icons.arrow_back_ios_new_sharp),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: Center(child: Event(id: widget.id)));
  }
}
