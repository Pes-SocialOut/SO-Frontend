import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({ Key? key }) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {

  final double lat = 41.3879;
  final double long = 2.16992;
  
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(lat, long),
        zoom: 13,
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
            point: LatLng(lat, long),
            builder: (context) =>  Icon(
              Icons.circle_outlined,
              color: Theme.of(context).colorScheme.primary,
              size: 40,
            )
          ),
        ],
      ),
      ],
    );
  }
}