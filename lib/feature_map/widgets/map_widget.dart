// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:so_frontend/feature_map/widgets/map_event.dart';

class MapWidget extends StatefulWidget {
  double lat,long;
  MapWidget({ Key? key, required this.lat, required this.long }) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
 
  showEvent() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        context: context,
        builder: (BuildContext context) {
          return const EventWidget();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(widget.lat, widget.long),
        zoom: 3,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(
        markers: [
          Marker(
            width: 40.0,
            height: 40.0,
            point: LatLng(widget.lat, widget.long),
            builder: (context) =>  Icon(
              Icons.circle,
              color: Theme.of(context).colorScheme.primary,
              size: 40,
            )
          ),
          Marker(
            width: 40.0,
            height: 40.0,
            point: LatLng(widget.lat + 0.1, widget.long + 0.1),
            builder: (context) =>  IconButton(
              icon: const Icon(Icons.location_on_sharp, size: 40),
              color:const Color.fromARGB(255, 205, 193, 93),
              onPressed: showEvent
            )
          )
        ],
      ),
      ],
    );
  }
}