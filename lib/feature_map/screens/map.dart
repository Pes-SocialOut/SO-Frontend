import 'package:flutter/material.dart';
import 'package:so_frontend/feature_map/widgets/map_widget.dart';
import 'package:so_frontend/feature_map/services/geolocation.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({ Key? key }) : super(key: key);

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  
  double lat = 0;
  double long = 0;
  GeolocationService gs = GeolocationService();

  assignLocation () async {
    List coords = await gs.getLocation(); 
    setState(() {
      lat = coords[0];
      long = coords[1];
    });
  }

  @override
  void initState() {
    super.initState();
    assignLocation();
    
  }

  @override
  Widget build(BuildContext context) {
    

    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          MapWidget(lat: lat, long: long),
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