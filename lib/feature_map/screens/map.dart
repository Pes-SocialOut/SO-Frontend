import 'package:flutter/material.dart';
import 'package:so_frontend/feature_map/widgets/map_widget.dart';

import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({ Key? key }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Position? _position;
  LocationPermission? _permission;
  bool _isLocationServiceEnabled = false;
  double lat = 0;
  double long = 0;

  Future<List> getLocation() async {
    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied)
      {
        _permission = await Geolocator.requestPermission();
      }
    else
      {
        _isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
        if (_isLocationServiceEnabled)
          {
            _position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);
            //placemarks = await placemarkFromCoordinates(position!.latitude, position!.longitude);
            //place = placemarks![0];
            //address = '${place?.street}, ${place?.postalCode}, ${place?.country}';
            return [_position!.latitude, _position!.longitude];
          }
      }
      return [15.0, 15.0];
  }

  assignLocation () async {
    List coords = await getLocation(); 
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
          lat == 0 && long == 0 ? Container(
            decoration: const BoxDecoration(
              color: Colors.grey
            )
          ) : MapWidget(lat: lat, long: long),
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