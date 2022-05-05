import 'package:flutter/material.dart';
import 'package:so_frontend/feature_user/services/login_signUp.dart';

class LinkScreen extends StatefulWidget {
  final String email;
  final String password;
  final String type;
  final String token;
  const LinkScreen(this.email, this.password, this.type, this.token, {Key? key})
      : super(key: key);
  @override
  LinkScreenState createState() => LinkScreenState();
}

class LinkScreenState extends State<LinkScreen> {
  final formKey = GlobalKey<FormState>();
  final userAPI uapi = userAPI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xC8C8C8),
        title: const Text('Link account'),
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
            Text(
              "Email is already registered with an associated account",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 50),
            Text(
              widget.email,
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 50),
            /*
            Form(
              key: formKey,
              child: ListView(
                children: <Widget>[
                  
                  
                ],
              ),
            ),
            */
          ]
          ),
      ),
       
    );
  }
}
