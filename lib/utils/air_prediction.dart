import 'package:flutter/material.dart';


class AirPrediction extends StatefulWidget {
  final String id;
  const AirPrediction({ Key? key, required this.id}) : super(key: key);

  @override
  State<AirPrediction> createState() => _AirPredictionState();
}

class _AirPredictionState extends State<AirPrediction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/2,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Bla, bla, bla'),
          SizedBox(height: 20),
        ]
      )
    );
  }
}