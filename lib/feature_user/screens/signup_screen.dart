import 'package:flutter/material.dart';
import 'package:so_frontend/feature_user/widgets/policy.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xC8C8C8),
        title: const Text('Sign Up')
      ),
      body: Center(
        child: Column(
          
          //scrossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height:300),
            Container(
              constraints: BoxConstraints(minWidth: 350,maxWidth:350),
              padding: EdgeInsets.all(10),
              child: PolicyWidget(),
            ),
            
            
          ] 
        ),
      )
    );
  }
}