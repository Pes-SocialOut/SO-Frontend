// ignore_for_file: must_be_immutable
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:so_frontend/feature_map/services/stations.dart';
import 'dart:convert';

class StationWidget extends StatefulWidget {
  final String id;
  const StationWidget({Key? key, required this.id}) : super(key: key);

  @override
  State<StationWidget> createState() => _StationWidgetState();
}

class _StationWidgetState extends State<StationWidget> {
  StationsAPI sj = StationsAPI();
  Map station = {};
  List pollutants = [];
  

  final String url2 =
      "https://socialout-develop.herokuapp.com/v1/air/stations/";

  var eventStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 22,
      height: 1.4);
  var explainStyle =
      const TextStyle(color: Color.fromARGB(255, 61, 60, 60), fontSize: 18);

  void getStation() async {
    Map tmp = await sj.getStation(widget.id);
    if (mounted) {
      setState(() {
        station = tmp;
        pollutants = station["pollutants"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getStation();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: http.get(Uri.parse(url2 + widget.id)),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var station = json.decode(snapshot.data.body);
            return Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Row(children: [
                    Text(
                      "${station["name"]}" + "station".tr(),
                      style: eventStyle,
                      textAlign: TextAlign.center,
                    ),

                  ]),
                  const Divider(
                      color: Color.fromARGB(255, 53, 52, 52),
                      height: 30,
                      indent: 30,
                      endIndent: 30),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            "Hereinfostation",
                            style: explainStyle,
                            textAlign: TextAlign.center,
                          ).tr(),
                        )
                      ]),
                  const Divider(indent: 50, endIndent: 50),
                  Row(children: [
                    (station["pollution"] < 0.15)
                        ? Text(
                            "ContLOW",
                            style: explainStyle,
                            textAlign: TextAlign.left,
                          ).tr()
                        : (station["pollution"] > 0.3)
                            ? Text(
                                "ContHIGH",
                                style: explainStyle,
                                textAlign: TextAlign.left,
                              ).tr()
                            : Text(
                                "ContMODERATE",
                                style: explainStyle,
                                textAlign: TextAlign.left,
                              ).tr(),
                    const SizedBox(width: 5),
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color.lerp(
                              Colors.green,
                              Color.lerp(
                                  Colors.yellow,
                                  Colors.red,
                              station['pollution'] < 0.15
                                  ? 0
                                  : (station['pollution'] >
                                          0.3
                                      ? 1
                                      : (station['pollution'] -
                                              0.15) /
                                          0.15)), station['pollution'] > 0.15
                                      ? 1
                                      : station['pollution'] /
                                          0.15)
                      )
                    ),
                  ]),
                  const Divider(indent: 50, endIndent: 50),
                  Text(
                        "Pollutants",
                        style: explainStyle,
                        textAlign: TextAlign.left,
                      ).tr(),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          for (var i = 0; i < pollutants.length; i++)
                            Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/10,
                                ),
                                Text(
                                  "${pollutants[i]["pollutant_composition"]}",
                                  style: explainStyle,
                                  textAlign: TextAlign.left,
                                ),
                                const Expanded(child: SizedBox()),
                                Text(
                                  "${pollutants[i]["value"]} µg/m3",
                                  style: explainStyle,
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(width: 5),
                                Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Color.lerp(
                                          Colors.green,
                                          Color.lerp(
                                              Colors.yellow,
                                              Colors.red,
                                          pollutants[i]['contaminant_scale'] < 0.15
                                              ? 0
                                              : (pollutants[i]['contaminant_scale'] >
                                                      0.3
                                                  ? 1
                                                  : (pollutants[i]['contaminant_scale'] -
                                                          0.15) /
                                                      0.15)), pollutants[i]['contaminant_scale'] > 0.15
                                                  ? 1
                                                  : pollutants[i]['contaminant_scale'] /
                                                      0.15)
                                  )
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/10,
                                ),
                              ],
                            )
                          ]
                      ),
                    ),
                  ),
                  const Divider(indent: 50, endIndent: 50),
                  Row(children: [
                    Expanded(
                      child: Text(
                        "Calculatedat".tr() +
                            "${station["last_calculated_at"]}",
                        style: explainStyle,
                        textAlign: TextAlign.left,
                      ),
                    )
                  ]),
                ]),
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
