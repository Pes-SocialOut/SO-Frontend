import 'package:flutter/material.dart';
import 'package:so_frontend/utils/air_prediction.dart';

showMLPredictions(BuildContext context, String id) {
  showDialog(
    context: context, 
    builder: (BuildContext context) => AlertDialog(
      title: Text('Air quality predictions', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 20, fontWeight: FontWeight.bold)),
      content:  AirPrediction(id: id)
    ),
    
  );
}