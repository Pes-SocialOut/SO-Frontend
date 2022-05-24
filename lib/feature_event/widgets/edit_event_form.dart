import 'package:flutter/material.dart';
import 'package:so_frontend/feature_event/services/edit.dart';
import 'dart:convert';

import 'package:so_frontend/utils/api_controller.dart';

class EditEventForm extends StatefulWidget {
  final String id;
  const EditEventForm({ Key? key, required this.id}) : super(key: key);

  @override
  State<EditEventForm> createState() => EditEventFormState();
}

class EditEventFormState extends State<EditEventForm> {

  APICalls api = APICalls();

  TextEditingController _name =  TextEditingController(text: '');
  TextEditingController _description =  TextEditingController(text: '');
  TextEditingController _max_participants =  TextEditingController(text: '');
  TextEditingController _lat = TextEditingController(text: '');
  TextEditingController _lng = TextEditingController(text: '');
  TextEditingController _image = TextEditingController(text: '');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  void setTextFields(dynamic event) {
    _name = TextEditingController(text: event[0]["name"]);
    _description = TextEditingController(text: event[0]["description"]);
    _lat = TextEditingController(text: event[0]["latitude"].toString());
    _lng = TextEditingController(text: event[0]["longitud"].toString());
    _image = TextEditingController(text: event[0]["event_image_uri"]);
    _max_participants = TextEditingController(text: event[0]["max_participants"].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
            future: api.getItem('/v3/events/:0', [widget.id]),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var event = [json.decode(snapshot.data.body)];
                setTextFields(event);
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Center(
                        child: Text('Edit event',
                          style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 24, fontWeight: FontWeight.bold)
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text('Name', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600, fontSize: 16)),
                      TextFormField(
                        controller: _name,
                        decoration: const InputDecoration(
                          hintText: 'Your event\'s awesome name'
                        ),
                      ),
                      const SizedBox(height:20),
                      Text('Description', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600, fontSize: 16)),
                      TextFormField(
                        controller: _description,
                        decoration: const InputDecoration(
                          hintText: 'Your event\'s awesome description'
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text('Max Attendees', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600, fontSize: 16)),
                      TextFormField(
                        controller: _max_participants,
                        decoration: const InputDecoration(
                          hintText: 'How many awesome people can join'
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text('Latitude', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600, fontSize: 16)),
                      TextFormField(
                        controller: _lat,
                        decoration: const InputDecoration(
                          hintText: 'Latitude'
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text('Longitude', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600, fontSize: 16)),
                      TextFormField(
                        controller: _lng,
                        decoration: const InputDecoration(
                          hintText: 'Longitude'
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text('Image Url', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600, fontSize: 16)),
                      TextFormField(
                        controller: _image,
                        decoration: const InputDecoration(
                          hintText: 'Your awesome image'
                        ),
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: InkWell(
                          onTap:() async {
                            // SAVE
                            Map<String, dynamic> body = {
                              "name": _name.text,
                              "description": _description.text,
                              "latitude": double.parse(_lat.text),
                              "longitud": double.parse(_lng.text),
                              "user_creator": event[0]["user_creator"],
                              "max_participants": int.parse(_max_participants.text),
                              "date_started": event[0]["date_started"],
                              "date_end": event[0]["date_end"],
                              "event_image_uri": _image.text
                            };
                            var response = await api.putItem('/v3/events/:0', [widget.id], body);
                            SnackBar snackBar;
                            if (response.statusCode == 201) {
                              snackBar = SnackBar(
                                backgroundColor: Theme.of(context).colorScheme.secondary,
                                content: const Text('Your event has been updated successfully!'),
                              );
                              Navigator.pop(context);
                            } else {
                              snackBar = SnackBar(
                                backgroundColor: Theme.of(context).colorScheme.error,
                                content: Text('Bad Request! ' + json.decode(response.body)["error_message"]),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Theme.of(context).colorScheme.onError,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.onError.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            width: 150,
                            height: 40,
                            child: Center(child: Text('UPDATE', style: TextStyle(color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.bold))),
                            
                          ),
                        ),
                      )
                    ]
                  )
                );
              }
              else {
                return const Center(
                  child: CircularProgressIndicator()
                );
              }
            } 
          )
        ),
      ),
    );
  }
}