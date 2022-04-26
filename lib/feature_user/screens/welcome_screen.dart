import 'package:flutter/material.dart';
import 'package:so_frontend/utils/theme.dart';
import 'package:hexcolor/hexcolor.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/frontpage/frontpage_1.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height:80),
                Image.asset(
                  "assets/Banner.png",
                  height: MediaQuery.of(context).size.height/10,
                  width: MediaQuery.of(context).size.width/1.5,
                  
                ),
                const SizedBox(height:50),
                const Text(
                  'Enjoy the day outside',
                  style: TextStyle(height: 1.0, fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height:300),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.secondary,
                    onPrimary: Colors.white,

                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  
                  child: const Text(
                    
                    'Sign Up',
                    style: TextStyle(height: 1.0, fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height:20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.onSecondary,
                    onPrimary: Colors.black,

                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                  child: const Text(
                    'Log In',
                    style: TextStyle(height: 1.0, fontSize: 30,  fontWeight: FontWeight.bold),
                  ),
                )
              ]
            ),
          )
        )
      ],
    );
    
  }
}