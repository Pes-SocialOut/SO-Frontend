import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:so_frontend/feature_event/screens/creation_sucess.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CreateEventForm extends StatefulWidget {
  const CreateEventForm({ Key? key }) : super(key: key);

  @override
  State<CreateEventForm> createState() => _CreateEventFormState();
}

class _CreateEventFormState extends State<CreateEventForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime _selectedTime = DateTime.now();

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
                  decoration: const InputDecoration(
                    hintText: 'What are we creating today?'
                  ),
                ),
                const SizedBox(height: 20),
                Text('Date and time', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600, fontSize: 16)),
                TextButton(
                  
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2018, 3, 5),
                      maxTime: DateTime.now(),
                      onChanged: (date) {
                        
                      }, 
                      onConfirm: (date) {
                        setState((){
                          _selectedTime = date;
                        });
                      }, 
                      currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Text(
                      ('' + _selectedTime.year.toString() + '/' + _selectedTime.month.toString() + '/' + _selectedTime.day.toString()),
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                  )),
                const SizedBox(height: 20),
                Text('Duration', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600, fontSize: 16)),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'How long will your event last?'
                  ),
                ),
                const SizedBox(height: 40),
                Text('Location', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600, fontSize: 16)),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Where will your event take place?'
                  ),
                ),
                const SizedBox(height: 20),
                Text('Max Participants', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600, fontSize: 16)),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'How many people will attend?'
                  ),
                ),
                const SizedBox(height: 20),
                Text('Description', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600, fontSize: 16)),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Let your attendees know what to expect...'
                  ),
                ),
                const SizedBox(height: 40),
                Text('Image', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600, fontSize: 16)),
                TextFormField(
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreationSucess())
            );
          },
          child: const Text('Create'),
        ),
        const SizedBox(height: 50),
      ]
    );
  }
}