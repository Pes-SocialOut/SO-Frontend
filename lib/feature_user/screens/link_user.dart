import 'package:flutter/material.dart';
import 'package:so_frontend/feature_user/services/login_signUp.dart';

class LinkScreen extends StatefulWidget {
  final String email;
  final String password;
  final String type;
  const LinkScreen(this.email, this.password, this.type, {Key? key})
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
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            Text(
              "Email is already registered with an associated account",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
