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
  late String verification;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xC8C8C8),
        title: const Text('Link account'),
      ),
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: ListView(children: <Widget>[
            Image.asset(
              "assets/Banner.png",
              height: MediaQuery.of(context).size.height / 10,
              width: MediaQuery.of(context).size.width / 1.5,
            ),
            const SizedBox(height: 50),
            Center(
              child: Text(
                "Email is already registered\n with an associated\n account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Text(
                widget.email,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            const SizedBox(height: 50),
            if (widget.type == 'socialout') codiVerification(),
            linkButton("socialout"),
            cancelButton(),
          ]),
        ),
      ),
    );
  }

  Widget linkButton(String s) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Theme.of(context).colorScheme.secondary,
            onPrimary: Theme.of(context).colorScheme.onSecondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size(200, 40)),
        onPressed: () {
          Navigator.of(context).pushNamed('/login');
        },
        child: const Text(
          'Link account',
          style: TextStyle(
            height: 1.0,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget codiVerification() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Verification Code",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(29))),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter verification code';
        }
        return null;
      },
      onSaved: (value) {
        verification = value.toString();
      },
    );
  }

  Widget cancelButton() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Theme.of(context).colorScheme.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size(200, 40)),
        onPressed: () {
          Navigator.of(context).pushNamed('/login');
        },
        child: const Text(
          'Cancel',
          style: TextStyle(
            height: 1.0,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
