import 'package:flutter/material.dart';
import 'package:so_frontend/feature_event/widgets/edit_event_form.dart';

class EditEventScreen extends StatelessWidget {
  final String id;
  const EditEventScreen({ Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit event',
            style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontSize: 16)),
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          iconSize: 24,
          color: Theme.of(context).colorScheme.onSurface,
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: EditEventForm(id: id)
    );
  }
}