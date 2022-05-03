// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:so_frontend/feature_map/services/stations.dart';

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
  double cont = 3;

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
        cont = station["pollution"];
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
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(children: [
          Row(children: [
            Expanded(
              child: Text(
                "${station["name"]} station",
                style: eventStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ]),
          const Divider(
              color: Color.fromARGB(255, 53, 52, 52),
              height: 30,
              indent: 30,
              endIndent: 30),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Expanded(
              child: Text(
                "Here you have all the information related to the station:",
                style: explainStyle,
                textAlign: TextAlign.center,
              ),
            )
          ]),
          const Divider(indent: 50, endIndent: 50),
          Row(children: [
            Expanded(
                child: (cont < 0.15)
                    ? Text(
                        "Contamination: LOW",
                        style: explainStyle,
                        textAlign: TextAlign.left,
                      )
                    : (cont > 0.3)
                        ? Text(
                            "Contamination: HIGH",
                            style: explainStyle,
                            textAlign: TextAlign.left,
                          )
                        : Text(
                            "Contamination: MODERATE",
                            style: explainStyle,
                            textAlign: TextAlign.left,
                          ))
          ]),
          const Divider(indent: 50, endIndent: 50),
          SingleChildScrollView(
            child: Row(children: [
              Text(
                "Pollutants: ",
                style: explainStyle,
                textAlign: TextAlign.left,
              ),
              for (var i = 0; i < pollutants.length; i++)
                Text(
                  "${pollutants[i]["pollutant_composition"]} ",
                  style: explainStyle,
                  textAlign: TextAlign.left,
                )
            ]),
          ),
          const Divider(indent: 50, endIndent: 50),
          Row(children: [
            Expanded(
              child: Text(
                "Calculated at: ${station["last_calculated_at"]}",
                style: explainStyle,
                textAlign: TextAlign.left,
              ),
            )
          ]),
        ]),
      ),
    );
  }
}
