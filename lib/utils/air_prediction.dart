import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:skeletons/skeletons.dart';
import 'package:so_frontend/utils/api_controller.dart';
import 'package:http/http.dart' as http;

class AirPrediction extends StatefulWidget {
  final String id;
  final String latitude;
  final String longitud;
  const AirPrediction({Key? key, required this.id, required this.latitude, required this.longitud}) : super(key: key);

  @override
  State<AirPrediction> createState() => _AirPredictionState();
}

class _AirPredictionState extends State<AirPrediction> {

  Future<dynamic> getPredictionByLocation(String longitud, String latitude, String day, String month, String year, String hour) async {

    var response = await http.get(Uri.parse("https://socialout-develop.herokuapp.com/v1/air/location?long=" + longitud + "&lat=" + latitude));
    var body = json.decode(response.body);
    List<String> stations = [];
    for (int i = 0; i < body["surrounding_measuring_stations"].length; ++i) {
      stations.add(body["surrounding_measuring_stations"][i]["id"]);
    }
    List<int > pollutants = [];
    for (int i = 0; i < stations.length; ++i) {
      var tmp = await http.get(Uri.parse("https://socialout-develop.herokuapp.com/v1/air/stations/" + stations[i]));
      pollutants.add(json.decode(tmp.body)["pollutants"].length);
    }
    //https://socialout-develop.herokuapp.com/v1/air/ml?codi_eoi1=43013002&contaminante1=7&dia=11&mes=2&year=2019&hora=12&codi_eoi2=43004005&contaminante2=4&codi_eoi3=43148022&contaminante3=8&longitud=0.2884&latitud=40.64299
    var predictionResponse;
    if (stations.length == 2) {
      predictionResponse = await http.get(Uri.parse("https://socialout-develop.herokuapp.com/v1/air/ml?codi_eoi1=" + stations[0] + "&contaminante1=" + pollutants[0].toString() + "&dia=" +  day + "&mes="+ month + "&year=" + year +"&hora=" + hour + "&codi_eoi2=" + stations[1] + "&contaminante2=" + pollutants[1].toString() + "&longitud=" + longitud + "&latitud=" + latitude));
    }
    else {
      predictionResponse = await http.get(Uri.parse("https://socialout-develop.herokuapp.com/v1/air/ml?codi_eoi1=" + stations[0] + "&contaminante1=" + pollutants[0].toString() + "&dia=" +  day + "&mes="+ month + "&year=" + year +"&hora=" + hour + "&codi_eoi2=" + stations[1] + "&contaminante2=" + pollutants[1].toString() + "&codi_eoi3=" + stations[2] +"&contaminante3=" + pollutants[2].toString() +"&longitud=" + longitud + "&latitud=" + latitude));
    }
    return predictionResponse;
  }

  APICalls api = APICalls();
  DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
  DateTime afterTomorrow = DateTime.now().add(const Duration(days: 2));


  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('airDescription').tr(),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Row(children: [
            const Text('Tomorrow',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16))
                .tr(),
            const Expanded(child: SizedBox()),
            FutureBuilder(
              future: getPredictionByLocation(widget.longitud, widget.latitude, tomorrow.day.toString(), tomorrow.month.toString(), tomorrow.year.toString(), tomorrow.hour.toString()),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print(snapshot.data.body);
                var _airQuality = json.decode(snapshot.data.body);
                
                return Container(
                  decoration: BoxDecoration(
                      color: _airQuality["pollution"] < 0.15
                          ? Theme.of(context).colorScheme.secondary
                          : _airQuality["pollution"] < 0.3
                              ? Theme.of(context).colorScheme.onError
                              : Theme.of(context).colorScheme.error,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 3.0, horizontal: 5.0),
                    child: _airQuality["pollution"] < 0.15
                        ? Text("GOOD",
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    fontWeight: FontWeight.bold))
                            .tr()
                        : _airQuality["pollution"] < 0.3
                            ? Text("MODERATE",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        fontWeight: FontWeight.bold))
                                .tr()
                            : Text("BAD",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        fontWeight: FontWeight.bold))
                                .tr(),
                  ),
                );
              } else {
                return SkeletonItem(
                    child: SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                            lines: 1,
                            spacing: 4,
                            lineStyle: SkeletonLineStyle(
                                width: 40,
                                height: 20,
                                borderRadius: BorderRadius.circular(10)))));
              }
            }),
          ]),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          Row(children: [
            const Text('Aftertomorrow',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16))
                .tr(),
            const Expanded(child: SizedBox()),
            FutureBuilder(
              future: getPredictionByLocation(widget.longitud, widget.latitude, afterTomorrow.day.toString(), afterTomorrow.month.toString(), afterTomorrow.year.toString(), afterTomorrow.hour.toString()),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var _airQuality = json.decode(snapshot.data.body);
                return Container(
                  decoration: BoxDecoration(
                      color: _airQuality["pollution"] < 0.15
                          ? Theme.of(context).colorScheme.secondary
                          : _airQuality["pollution"] < 0.3
                              ? Theme.of(context).colorScheme.onError
                              : Theme.of(context).colorScheme.error,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 3.0, horizontal: 5.0),
                    child: _airQuality["pollution"] < 0.15
                        ? Text("GOOD",
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    fontWeight: FontWeight.bold))
                            .tr()
                        : _airQuality["pollution"] < 0.3
                            ? Text("MODERATE",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        fontWeight: FontWeight.bold))
                                .tr()
                            : Text("BAD",
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        fontWeight: FontWeight.bold))
                                .tr(),
                  ),
                );
              } else {
                return SkeletonItem(
                    child: SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                            lines: 1,
                            spacing: 4,
                            lineStyle: SkeletonLineStyle(
                                width: 40,
                                height: 20,
                                borderRadius: BorderRadius.circular(10)))));
              }
            }),
            const Divider()
          ]),
        ]));
  }
}
