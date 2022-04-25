import 'package:flutter/material.dart';
import 'package:so_frontend/feature_event/widgets/create_form.dart';


class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({ Key? key }) : super(key: key);

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Center(child: Padding(
        padding: EdgeInsets.all(8.0),
        child: CreateEventForm(),
      )),
    );
  }
}