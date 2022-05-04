import 'package:flutter/material.dart';
import 'package:so_frontend/feature_event/screens/map_event_screen.dart';

class EventMapButton extends StatelessWidget {
  final double lat, lng;
  const EventMapButton({ Key? key, required this.lat, required this.lng }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) =>  MapEventScreen(lat: lat, lng: lng))
            );
          },
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width/1.3,
            height: MediaQuery.of(context).size.height/6,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: FittedBox(
                child: Image.asset('assets/map_preview.png'), 
                fit: BoxFit.fitWidth
              ),
              
            )
          )
        )
      ),
    );
  }
}