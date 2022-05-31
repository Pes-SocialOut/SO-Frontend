import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/feature_chat/screens/listChat_screen.dart';
import 'package:so_frontend/feature_event/widgets/user_event.dart';
import 'package:so_frontend/feature_event/screens/edit_event_screen.dart';

class UserEventScreen extends StatelessWidget {
  final String id;
  const UserEventScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(id);
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('Event',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 16))
                .tr(),
            backgroundColor: Theme.of(context).colorScheme.background,
            actions: <Widget>[
              IconButton(
                  iconSize: 24,
                  color: Theme.of(context).colorScheme.onSurface,
                  icon: const Icon(Icons.create_sharp),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditEventScreen(id: id)));
                  }),
              IconButton(
                iconSize: 24,
                color: Theme.of(context).colorScheme.onSurface,
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListChatScreen(
                                id_event: id,
                              )));
                },
                icon: const Icon(
                  Icons.message,
                ),
              ),
            ],
            leading: IconButton(
              iconSize: 24,
              color: Theme.of(context).colorScheme.onSurface,
              icon: const Icon(Icons.arrow_back_ios_new_sharp),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: Center(child: UserEvent(id: id)));
  }
}
