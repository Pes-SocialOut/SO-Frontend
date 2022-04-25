import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome'),
            const SizedBox(height:20),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/login');
              },
              child: Container(
                width: 400,
                height: 100,
                child: Icon(Icons.login),
              )
            ),
            const SizedBox(height:20),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/signup');
              },
              child: Container(
                width: 400,
                height: 100,
                child: Icon(Icons.add),
              )
            )
          ]
        ),
      )
    );
  }
}