import 'package:flutter/material.dart';
import 'package:so_frontend/feature_home/screens/home.dart';
import 'package:so_frontend/feature_map/screens/map.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SocialOut',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:ColorScheme(
          brightness:Brightness.light,
          primary: HexColor('22577A'),
          onPrimary: Colors.white,
          secondary: HexColor('38A3A5'),
          onSecondary: Colors.white,
          error: HexColor('ED4337'),
          onError: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
          surface: Colors.black,
          onSurface: Colors.white,
        )
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

