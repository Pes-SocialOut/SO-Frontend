import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:skeletons/skeletons.dart';

class AirPrediction extends StatefulWidget {
  final String id;
  const AirPrediction({Key? key, required this.id}) : super(key: key);

  @override
  State<AirPrediction> createState() => _AirPredictionState();
}

class _AirPredictionState extends State<AirPrediction> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Divider(),
          const SizedBox(height: 20),
          Row(children: [
            const Text('Tomorrow',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16))
                .tr(),
            const Expanded(child: SizedBox()),
            FutureBuilder(
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
          ]),
        ]));
  }
}
