// ignore_for_file: file_names

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:so_frontend/feature_user/screens/link_user.dart';
import 'package:so_frontend/feature_user/services/login_signUp.dart';
import 'package:so_frontend/feature_user/widgets/policy.dart';

import 'form_register.dart';

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
  late String confirm;
  bool showPassword1 = true;
  bool isPasswordTextField1 = true;
  bool showPassword2 = true;
  bool isPasswordTextField2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x00c8c8c8),
        title: const Text('Register!'),
      ),
      body: Form(
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
                obscureText: isPasswordTextField1 ? showPassword1 : false,
                decoration: InputDecoration(
                  suffixIcon: isPasswordTextField1
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword1 = !showPassword1;
                            });
                          },
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        )
                      : null,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(29)),
                  ),
                  hintText: "Enter password",
                  labelText: "Password",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "a password is required";
                  } else {
                    RegExp regex =
                        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
                    if (!regex.hasMatch(value)) {
                      return 'Enter valid password: min8caracters(numeric,UpperCase,LowerCase)';
                    } else {
                      return null;
                    }
                  }
                },
                onSaved: (value) {
                  password = value.toString();
                },
              ),
            ),

            //CONFIRM PASSWORD
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                keyboardType: TextInputType.text,
                obscureText: isPasswordTextField2 ? showPassword2 : false,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(29)),
                  ),
                  suffixIcon: isPasswordTextField2
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword2 = !showPassword2;
                            });
                          },
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        )
                      : null,
                  hintText: "Enter Confirm password",
                  labelText: "Confirm password",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "a confirm password is required";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  confirm = value.toString();
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
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (confirm != password) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          title: const Text("Fail register"),
                          content: const Text(
                              "password and confirm password do not match"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Ok"),
                            ),
                          ],
                        ),
                      );
                    } else {
                      Map<String, dynamic> ap =
                          await uapi.checkUserEmail(email);

                      if (ap["action"] == "continue") {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FormRegister(email, password)),
                            (route) => false);
                      } else if (ap["action"] == "link_auth") {
                        //enlazar cuentas
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            title: const Text(
                                "Authentication method not available for this email, existe account with this email"),
                            content: const Text(
                                "Do you want to connect the account of SocialOut??"),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () => {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LinkScreen(email, password,
                                                        "socialout", "")),
                                            (route) => false)
                                      },
                                  //Navigator.of(context).pushNamed('/welcome'),
                                  child: const Text("Yes")),
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text("No")),
                            ],
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            title: const Text("Fail register"),
                            content: const Text("Account already exists"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text("Ok"),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  }
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
    );
  }
}
