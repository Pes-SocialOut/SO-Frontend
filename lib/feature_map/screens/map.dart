import 'package:flutter/material.dart';
import 'package:so_frontend/feature_map/widgets/map_widget.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
              backgroundColor: Theme.of(context).colorScheme.background,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 22,
                  color: Theme.of(context).colorScheme.onBackground
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