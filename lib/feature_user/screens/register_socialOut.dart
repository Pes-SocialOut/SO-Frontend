// ignore_for_file: file_names

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/feature_user/services/login_signUp.dart';
import 'package:so_frontend/feature_user/widgets/policy.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final userAPI uapi = userAPI();
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xC8C8C8),
        title: const Text('Register!'),
      ),
      body: Container(
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 50),
              Image.asset(
                "assets/Banner.png",
                height: MediaQuery.of(context).size.height / 10,
                width: MediaQuery.of(context).size.width / 1.5,
              ),
              const SizedBox(height: 60),
              //EMAIL
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(29)),
                    ),
                    hintText: "Enter email",
                    labelText: "Email",
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                      return "a valid email is required";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    email = value.toString();
                  },
                ),
              ),
              //PASSWORD
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(29)),
                    ),
                    hintText: "Enter password",
                    labelText: "Password",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "a password is required";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    password = value.toString();
                  },
                ),
              ),
              const SizedBox(height: 30),
              //REGISTER BUTTON
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.secondary,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(200, 40),
                  ),
                  onPressed: () async {
                    /* if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      Map<String, dynamic> ap =
                          await uapi.checkUserEmail(email);
                      if (ap["action"] == "continue") {
                        print(email);
                        print(password);
                      }
                    }*/
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/form_register', (Route<dynamic> route) => false);
                    // llamar a funcion checkUserEmail https
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        height: 1.0, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                          fontSize: 14,
                        ),
                        text: "Do you already have an account? ",
                      ),
                      TextSpan(
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 14,
                        ),
                        text: "Login",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushNamed('/login');
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const PolicyWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
