import 'package:flutter/material.dart';
import 'package:so_frontend/feature_event/widgets/create_confirmation.dart';

class CreationSucess extends StatelessWidget {
  const CreationSucess({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Create', style: TextStyle(color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.w600, fontSize: 16)),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Theme.of(context).colorScheme.background,

      ),
      body: const ConfirmationMessage()
    );
  }
}