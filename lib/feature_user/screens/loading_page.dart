import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/feature_user/screens/welcome_screen.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 10),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => WelcomeScreen())));
    return Stack(children: <Widget>[
      Image.asset(
        "assets/frontpage/frontpage_1_small.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                const SizedBox(height: 80),
                Image.asset(
                  "assets/Banner.png",
                  height: MediaQuery.of(context).size.height / 10,
                  width: MediaQuery.of(context).size.width / 1.5,
                ),
                const SizedBox(height: 20),
                const Text(
                  'welcome',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1.0,
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ).tr(),
                const SizedBox(height: 300),
              ])))
    ]);
  }
}
