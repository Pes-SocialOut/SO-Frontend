import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class AirTag extends StatefulWidget {
  final String longitud;
  final String latitude;
  const AirTag({ Key? key, required this.longitud, required this.latitude}) : super(key: key);

  @override
  State<AirTag> createState() => _AirTagState();
}

class _AirTagState extends State<AirTag> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: http.get(Uri.parse('https://socialout-develop.herokuapp.com/v1/air/location?long=' + widget.longitud + '&lat=' + widget.latitude)),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var _airQuality = [json.decode(snapshot.data.body)];
          return Container(
            decoration: BoxDecoration(
              color: _airQuality[0]["pollution"] < 0.15 ? Theme.of(context).colorScheme.secondary : _airQuality[0]["pollution"] < 0.3 ? Theme.of(context).colorScheme.onError : Theme.of(context).colorScheme.error,
              borderRadius: const BorderRadius.all(Radius.circular(25))
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 3.0,
                horizontal: 5.0
              ),
              child:  _airQuality[0]["pollution"] < 0.15 ? Text("GOOD", style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.bold)) : _airQuality[0]["pollution"] < 0.3 ? Text("MODERATE", style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.bold)) : Text("BAD", style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.bold)), 
            ),
            
          );
        }
        else {
          return const CircularProgressIndicator();
        }
      }
    );
  }
}