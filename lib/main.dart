import 'package:flutter/material.dart';
import 'package:so_frontend/feature_home/screens/home.dart';
import 'package:so_frontend/feature_map/screens/map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      home: const HomeScreen(),
      routes: {
        '/home': (_) => const HomeScreen(),
        '/map_screen': (_) => const MapScreen(),
      },
    );
  }
}

