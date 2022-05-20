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
import 'package:so_frontend/feature_user/screens/change_password.dart';
import 'package:so_frontend/utils/api_controller.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    APICalls().tryInitializeFromPreferences();
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'SocialOut',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        cardColor: Colors.white,
        primaryColor: Colors.green,
        tabBarTheme:  TabBarTheme(
          labelColor: Theme.of(context).colorScheme.secondary,
          labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.secondary),   // color for text
          indicator: UnderlineTabIndicator( // color for indicator (underline)
          borderSide: BorderSide(
            width: 2,
            color: Theme.of(context).colorScheme.primary)
          ),
        ),
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: HexColor('22577A'),
            onPrimary: Colors.white,
            secondary: HexColor('38A3A5'),
            onSecondary: Colors.white,
            error: HexColor('ED4337'),
            onError: HexColor('D4AC2B'),
            background: Colors.white,
            onBackground: Colors.black,
            surface: Colors.black,
            onSurface: HexColor('767676'),
          )),
      initialRoute: '/welcome',
      home: const WelcomeScreen(),
      routes: {
        '/welcome': (_) => const WelcomeScreen(),
        '/login': (_) => const LoginScreen(),
        '/signup': (_) => SignUpScreen(),
        '/register': (_) => const RegisterScreen(),
        '/home': (_) => const NavigationBottomBar(),
        '/map_screen': (_) => const MapScreen(),
        '/profile': (_) => const ProfileScreen(id: "0"),
        '/edit_profile': (_) => const EditarProfile(),
        '/change_password': (_) => const ChangePassword(),
      },
    );
  }
}
