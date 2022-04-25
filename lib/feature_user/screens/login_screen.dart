import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: const Icon(Icons.login),
          onPressed: () {
            Navigator.of(context).pushNamed('/home');
          }
        )
      )
    );
  }
}