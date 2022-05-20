import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:so_frontend/feature_event/screens/creation_sucess.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'dart:convert';

class CreateEventForm extends StatefulWidget {
  const CreateEventForm({ Key? key }) : super(key: key);

  @override
  State<CreateEventForm> createState() => _CreateEventFormState();
}

class _CreateEventFormState extends State<CreateEventForm> {

  APICalls api = APICalls();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime _selectedStartedTime = DateTime.now();
  TimeOfDay _startedtime = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);


  DateTime _selectedEndTime = DateTime.now();
  TimeOfDay _endtime = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute + 1);

  List event = [];

  TextEditingController _name =  TextEditingController(text: '');
  TextEditingController _description =  TextEditingController(text: '');
  TextEditingController _latitude =  TextEditingController(text: '');
  TextEditingController _longitude =  TextEditingController(text: '');
  TextEditingController _max_participants =  TextEditingController(text: '');
  TextEditingController _image = TextEditingController(text: '');


  void _selectTime() async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _startedtime,
    );
    if (newTime != null) {
      setState(() {
        _startedtime = newTime;
        _endtime = newTime;
      });
    }
  }

  void _selectEndTime() async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _endtime,
    );
    if (newTime != null) {
      setState(() {
        _endtime = newTime;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height/8),
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Start creating your ',
                  style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Theme.of(context).colorScheme.surface),
                  children:  <TextSpan> [
                    TextSpan(
                      text: 'dream ',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary,  fontSize: 28)
                    ),
                    TextSpan(
                      text: 'event!',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Theme.of(context).colorScheme.surface)
                    )
                  ]
                )
              ),
              const SizedBox(height: 20),
              Text('Fill all the information required to create a new event',textAlign: TextAlign.center,  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Theme.of(context).colorScheme.onSurface)),
              SizedBox(height: MediaQuery.of(context).size.height/8),
            ],
          ),
        ),
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600, fontSize: 16)),
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(
                    hintText: 'What are we creating today?'
                  ),
                ),
                const SizedBox(height: 20),
                Text('Date and time at which the event starts', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600, fontSize: 16)),
                Row(
                  children: [
                    TextButton(
                  
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      maxTime: DateTime(2100, 1, 1),
                      minTime: DateTime.now(),
                      onChanged: (date) {
                        
                      }, 
                      onConfirm: (date) {
                        setState((){
                          _selectedStartedTime = date;
                          _selectedEndTime = date;
                        });
                      }, 
                      currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Text(
                      ('' + _selectedStartedTime.year.toString() + '/' + _selectedStartedTime.month.toString() + '/' + _selectedStartedTime.day.toString()),
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                  )),
                  const SizedBox(width: 40),
                  TextButton(
                  
                  onPressed: _selectTime,
                  child: Text(
                      _startedtime.hour.toString() + ':' + _startedtime.minute.toString(),
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                  )),
                  ]
                ),
                const SizedBox(height: 20),
                Text('Date and time at which the event ends', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600, fontSize: 16)),
                Row(
                  children: [
                    TextButton(
                  
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      maxTime: DateTime(2100, 1, 1),
                      minTime: DateTime.now(),
                      onChanged: (date) {
                        
                      }, 
                      onConfirm: (date) {
                        setState((){
                          _selectedEndTime = date;
                        });
                      }, 
                      currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Text(
                      ('' + _selectedEndTime.year.toString() + '/' + _selectedEndTime.month.toString() + '/' + _selectedEndTime.day.toString()),
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                  )),
                  const SizedBox(width: 40),
                  TextButton(
                  onPressed: _selectEndTime,
                  child: Text(
                      _endtime.hour.toString() + ':' + _endtime.minute.toString(),
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                  )),
                  ]
                ),
                const SizedBox(height: 40),
                Text('Location', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600, fontSize: 16)),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _longitude,
                        decoration: const InputDecoration(
                          hintText: 'Longitude'
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: TextFormField(
                        controller: _latitude,
                        decoration: const InputDecoration(
                          hintText: 'Latitude'
                        ),
                      ),
                    ),
                  ]
                ),
                const SizedBox(height: 20),
                Text('Max Participants', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600, fontSize: 16)),
                TextFormField(
                  controller: _max_participants,
                  decoration: const InputDecoration(
                    hintText: 'How many people will attend?'
                  ),
                ),
                const SizedBox(height: 20),
                Text('Description', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600, fontSize: 16)),
                TextFormField(
                  controller: _description,
                  decoration: const InputDecoration(
                    hintText: 'Let your attendees know what to expect...'
                  ),
                ),
                const SizedBox(height: 40),
                Text('Image', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600, fontSize: 16)),
                TextFormField(
                  controller: _image,
                  decoration: const InputDecoration(
                    hintText: 'Add an image which represents your event'
                  ),
                ),
                const SizedBox(height: 20),
                
              ],
            ),
          ),
        ),
        const SizedBox(height: 50),
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 16,
              left: 100,
              right: 100
            ),
            primary: Colors.white,
            backgroundColor: HexColor('57CC99'),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          onPressed: () async {
            Map<String, dynamic> body = {
              "name": _name.text,
              "description": _description.text,
              "date_started": _selectedStartedTime.year.toString()+'-'+_selectedStartedTime.month.toString()+'-'+_selectedStartedTime.day.toString()+' '+_startedtime.hour.toString()+':'+_startedtime.minute.toString()+':00',
              "date_end": _selectedEndTime.year.toString()+'-'+_selectedEndTime.month.toString()+'-'+_selectedEndTime.day.toString()+' '+_endtime.hour.toString()+':'+_endtime.minute.toString()+':00',
              "user_creator": api.getCurrentUser(),
              "longitud": double.parse(_longitude.text),
              "latitude": double.parse(_latitude.text),
              "max_participants": int.parse(_max_participants.text),
              "event_image_uri": _image.text
            };

            print(body);
            var response = await api.postItem('/v3/events/', [], body);
            print(api.getCurrentAccess());
            print(response.body);
            var snackBar;
            if (response.statusCode == 201) {
                snackBar = SnackBar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                content: const Text('Your event has been created successfully!'),
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  CreationSucess(image: _image.text))
              );
            } else if (response.statusCode == 400) {
                snackBar = SnackBar(
                backgroundColor: Theme.of(context).colorScheme.error,
                content: Text('Bad Request! ' + json.decode(response.body)["error_message"]),
              );
            } else {
              snackBar = SnackBar(
                backgroundColor: Theme.of(context).colorScheme.error,
                content: const Text('Something went wrong! Try again later'),
              );
            }


            // // Find the ScaffoldMessenger in the widget tree
            // // and use it to show a SnackBar.
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            
          },
          child: const Text('Create'),
        ),
        const SizedBox(height: 50),
      ]
    );
  }
}

