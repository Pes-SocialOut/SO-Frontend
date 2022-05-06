import 'package:flutter/material.dart';
import 'package:so_frontend/feature_map/screens/map.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:so_frontend/feature_navigation/screens/navigation.dart';
import 'package:so_frontend/feature_navigation/screens/profile.dart';
import 'package:so_frontend/feature_user/screens/edit_profile.dart';
import 'package:so_frontend/feature_user/screens/login_screen.dart';
import 'package:so_frontend/feature_user/screens/register_socialOut.dart';
import 'package:so_frontend/feature_user/screens/welcome_screen.dart';
import 'package:so_frontend/feature_user/screens/signup_screen.dart';
import 'package:so_frontend/utils/api_controller.dart';

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
          colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: HexColor('22577A'),
        onPrimary: Colors.white,
        secondary: HexColor('38A3A5'),
        onSecondary: Colors.white,
        error: HexColor('ED4337'),
        onError: Colors.white,
        background: Colors.white,
        onBackground: Colors.black,
        surface: Colors.black,
        onSurface: HexColor('767676'),
      )),
      initialRoute: '/welcome',
      home: const WelcomeScreen(),
      routes: {
        '/welcome': (_) => const WelcomeScreen(),
        '/login': (_) => LoginScreen(),
        '/signup': (_) =>  SignUpScreen(),
        '/register': (_) => const RegisterScreen(),
        '/home': (_) => const NavigationBottomBar(),
        '/map_screen': (_) => const MapScreen(),
        '/profile': (_) => const ProfileScreen(),
        '/edit_profile': (_) => const EditarProfile(),
      },
    );
  }
}
