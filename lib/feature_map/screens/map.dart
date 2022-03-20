import 'package:flutter/material.dart';
import 'package:so_frontend/feature_map/widgets/map_widget.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const MapWidget(),
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
              left: 16
            ),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 22,
                  color: Colors.black
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          )
          
        ]
      )
    );
  }
}