import 'package:flutter/material.dart';

class EditEventForm extends StatefulWidget {
  final String id;
  const EditEventForm({ Key? key, required this.id}) : super(key: key);

  @override
  State<EditEventForm> createState() => EditEventFormState();
}

class EditEventFormState extends State<EditEventForm> {

  TextEditingController _name =  TextEditingController(text: '');
  TextEditingController _description =  TextEditingController(text: '');
  TextEditingController _maxAttendees =  TextEditingController(text: '');
  TextEditingController _lat = TextEditingController(text: '');
  TextEditingController _lng = TextEditingController(text: '');
  TextEditingController _image = TextEditingController(text: '');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List _event = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _event = [{"id":'1', "title": "Gastronomic Route through El Born", "creator":"Mark", "date": "THURSDAY, 3 MAR · 17:00", "air_quality":"MODERATE", "description": 'Hello everybody! If you like chess as much as I do, you have to come to this open-air tournament in Tetuan square in Barcelona. There will be drinks and food until one of us wins. Don\'t miss this opportunity and sign up now!', "numAttendees": "17", "maxAttendees":"20", "lat": "21", "lng": "0", "image": "http://estaticos.elmundo.es/assets/multimedia/imagenes/2014/11/01/14148591827909.jpg"}];
      _name = TextEditingController(text:_event[0]["title"]);
      _description = TextEditingController(text: _event[0]["description"]);
      _maxAttendees = TextEditingController(text: _event[0]["maxAttendees"]);
      _lat = TextEditingController(text: _event[0]["lat"]);
      _lng = TextEditingController(text: _event[0]["lng"]);
      _image = TextEditingController(text: _event[0]["image"]);
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Form(
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
                  controller: _maxAttendees,
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
                    onTap:() {
                      // SAVE
                      Navigator.pop(context);
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
          )
        ),
      ),
    );
  }
}