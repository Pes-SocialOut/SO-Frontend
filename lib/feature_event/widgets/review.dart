import 'package:flutter/material.dart';
import 'package:so_frontend/utils/api_controller.dart';

class ReviewMenu extends StatefulWidget {
  final String id;
  const ReviewMenu({ Key? key , required this.id}) : super(key: key);

  @override
  State<ReviewMenu> createState() => _ReviewMenuState();
}

class _ReviewMenuState extends State<ReviewMenu> {

  double _rating = 3;
  TextEditingController _comment = TextEditingController(text: '');
  APICalls api = APICalls();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/1.2,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text('Time to review this event!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Divider(),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 20),
              Text('0', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onError)),
              Icon(Icons.star, color: Theme.of(context).colorScheme.onError, size: 20),
              const Expanded(
                child: SizedBox()
              ),
              Text('5', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onError)),
              Icon(Icons.star, color: Theme.of(context).colorScheme.onError, size: 20),
              const SizedBox(width: 20)
            ],
          ),
          const SizedBox(height: 10),
          Slider(
            activeColor: Theme.of(context).colorScheme.onError,
            inactiveColor: Theme.of(context).colorScheme.onError.withOpacity(0.4),
            value: _rating,
            divisions: 5,
            max: 5,
            label: _rating.toString(),
            onChanged: (double value) {
              setState(() {
                _rating = value;
              });
            }
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width/1.2,
            child: TextFormField(
              controller: _comment,
              decoration:  InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.secondary)
                ),
                hintText: 'What do you think of the event?'
              ),
            ),
          ),
          const SizedBox(height: 60),
          InkWell(
            onTap: () async {
              var  bodyData = {
                "event_id": widget.id,
                "user_id": api.getCurrentUser(),
                "rating": _rating.toInt(),
                "comment": _comment.text
              };
              var response = await api.postItem('/v3/events/:0', ["review"], bodyData);
              print(response.body);
              SnackBar snackBar;
              if (response.statusCode == 200) {
                snackBar = SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  content: const Text('Your event has been created successfully!'),
                );
              } else {
                snackBar = SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  content: const Text('Something bad happened! Try again later...'),
                );
              }
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Theme.of(context).colorScheme.secondary,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              width: 150,
              height: 40,
              child: Center(child: Text('SEND', style: TextStyle(color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.bold))),
            ),
          ),
        ]
      )
    );
  }
}