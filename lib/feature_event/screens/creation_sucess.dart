import 'package:flutter/material.dart';
import 'package:so_frontend/feature_event/widgets/create_confirmation.dart';

class CreationSucess extends StatelessWidget {
  final String image;
  const CreationSucess({ Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Create', style: TextStyle(color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.w600, fontSize: 16)),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          iconSize: 24,
          color: Theme.of(context).colorScheme.onSurface,
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ),
      body: ConfirmationMessage(image: image)
    );
  }
}