// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:so_frontend/feature_map/widgets/map_event.dart';
import 'package:so_frontend/feature_map/widgets/map_station.dart';
import 'dart:convert';
import 'package:so_frontend/feature_map/services/stations.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'package:http/http.dart' as http;

class MapWidget extends StatefulWidget {
  double lat, long;
  bool isEvent;
  MapWidget({Key? key, required this.lat, required this.long, required this.isEvent})
      : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {

  List events = [];
  StationsAPI sj = StationsAPI();
  List stations = [];
  APICalls api = APICalls();

  showEvent(Map<String, dynamic> event, double pollution) {
    showModalBottomSheet(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        context: context,
        builder: (BuildContext context) {
          return  EventWidget(event: event, pollution: pollution);
        });
  }

  showStation(String id) {
    showModalBottomSheet(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        context: context,
        builder: (BuildContext context) {
          return StationWidget(id: id);
        });
  }


  // void getAllStations() async {
  //   List tmp = await sj.getAllStations();
  //   if (mounted) {
  //     setState(() {
  //       stations = tmp;
  //     });
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getAllStations();
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api.getCollection('/v3/events/', [], null),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var events = json.decode(snapshot.data.body);
          return FutureBuilder(
            future: http.get(Uri.parse("https://socialout-develop.herokuapp.com/v1/air/stations")),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var stations = json.decode(snapshot.data.body);
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
                        !widget.isEvent ? Marker(
                            width: 40.0,
                            height: 40.0,
                            point: LatLng(widget.lat, widget.long),
                            builder: (context) => Icon(
                              Icons.circle,
                              color: Theme.of(context).colorScheme.primary,
                              size: 40,
                            )
                          ) : Marker(point:LatLng(widget.lat, widget.long), builder: (context) =>  const SizedBox()),
                        for (var i = 0; i < events.length; i++)
                          Marker(
                              width: 40.0,
                              height: 40.0,
                              point: LatLng(events[i]["latitude"], events[i]["longitud"]),
                              builder: (context) => FutureBuilder(
                                future: http.get(Uri.parse("https://socialout-develop.herokuapp.com/v1/air/location?long=" + events[i]["longitud"].toString() + "&lat=" + events[i]["latitude"].toString())),
                                builder: (BuildContext context, AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    var color = json.decode(snapshot.data.body);
                                    return IconButton(
                                      icon: const Icon(Icons.location_on_sharp, size: 40),
                                      onPressed: () => showEvent(
                                        events[i],
                                        color["pollution"]),
                                    color: Color.lerp(
                                        Colors.green,
                                        Color.lerp(
                                            Colors.yellow,
                                            Colors.red,
                                            
                                        color['pollution'] < 0.15
                                            ? 0
                                            : (color['pollution'] >
                                                    0.3
                                                ? 1
                                                : (color['pollution'] -
                                                        0.15) /
                                                    0.15)), color['pollution'] > 0.15
                                                ? 1
                                                : color['pollution'] /
                                                    0.15),);
                                  } 
                                  else {
                                    return IconButton(
                                      icon: const Icon(Icons.location_on_sharp, size: 40),
                                      onPressed: () {},
                                      color: Theme.of(context).colorScheme.onSurface,
                                    );
                                  }
                                } 
                              )),
                        for (var i = 0; i < stations.length; i++)
                          stations[i]["lat"] != null && stations[i]["long"] != null && stations[i]["pollution"] != null  ? Marker(
                              width: 35.0,
                              height: 35.0,
                              point: LatLng(stations[i]["lat"], stations[i]["long"]),
                              builder: (context) => IconButton(
                                  icon: const Icon(Icons.device_thermostat, size: 30),
                                  onPressed: () => showStation(stations[i]["id"]),
                                  color: Color.lerp(
                                        Colors.green,
                                        Color.lerp(
                                            Colors.yellow,
                                            Colors.red,
                                            
                                        stations[i]['pollution'] < 0.15
                                            ? 0
                                            : (stations[i]['pollution'] >
                                                    0.3
                                                ? 1
                                                : (stations[i]['pollution'] -
                                                        0.15) /
                                                    0.15)), stations[i]['pollution'] > 0.15
                                                ? 1
                                                : stations[i]['pollution'] /
                                                    0.15))) : Marker(point: LatLng(0.0, 0.0), builder: (context) => const SizedBox())
                      ],
                    ),
                  ],
                );
              }
              else {
                return const Center(
                  child: CircularProgressIndicator()
                );
              }
            } 
          );
        }
        else {
          return const Center(
            child: CircularProgressIndicator()
          );
        }
      } 
    );
  }
}
