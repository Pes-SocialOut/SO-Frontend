import 'package:flutter/material.dart';
import 'package:so_frontend/feature_user/widgets/policy.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register')
      ),
      body: Center(
        child: Column(
          //scrossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            PolicyWidget(),
          ] 
        ),
      )
    );
  }
}