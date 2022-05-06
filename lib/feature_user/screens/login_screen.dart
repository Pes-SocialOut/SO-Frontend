import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:so_frontend/feature_user/screens/link_user.dart';
import 'package:so_frontend/feature_user/services/login_signUp.dart';
import 'package:so_frontend/feature_user/widgets/policy.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/signIn_google.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final userAPI uapi = userAPI();
  late String email;
  late String password;
  late String verification;
  double borderradius = 10.0;
  double widthButton = 300.0;
  double heightButton = 40.0;
  double policyTextSize = 14;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xC8C8C8),
            title: const Text('Hello Agian!')),
        body: Form(
          key: formKey,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: SignInButton(
                    Buttons.Google,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderradius)),
                    text: "Log in with Google",
                    onPressed: () => _handleLoginGoogle(context),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: SignInButton(
                    Buttons.Facebook,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderradius)),
                    text: "Log in with Facebook",
                    onPressed: () {},
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: "Enter email", labelText: "Email"),
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
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Enter password",
                      labelText: "Password",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "a password is required";
                      } else {
                        RegExp regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
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
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.secondary,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderradius)),
                        minimumSize: Size(widthButton, heightButton)),
                    onPressed: () async {
                      /*  Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LinkScreen(
                                  "zjqtlwj@gmail.com",
                                  "XIEqiaochu0829",
                                  "socialout",
                                  "")),
                          (route) => false); */
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        Map<String, dynamic> ap =
                            await uapi.checkloginSocialOut(email);
                        if (ap["action"] == "continue") {
                          int aux = await uapi.loginSocialOut(email, password);
                          if (aux == 200) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/home', (route) => false);
                          }
                        } else if (ap["action"] == "link_auth") {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LinkScreen(
                                      email, password, "socialout", "")),
                              (route) => false);
                        } else {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => AlertDialog(
                              title: const Text("Fail Login"),
                              content: const Text("Account does not exist"),
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
                    },
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                          height: 1.0,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                      child: Text(
                        'Forget password?',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: policyTextSize),
                      ),
                      onTap: () async {
                        final Uri uri =
                            Uri(scheme: 'https', host: 'www.github.com');
                        await launchUrl(uri);
                      }),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.surface,
                              fontSize: policyTextSize),
                          text: "Don't haven an account? "),
                      TextSpan(
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: policyTextSize),
                          text: "Sign up",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushNamed('/signup');
                            }),
                    ]),
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const PolicyWidget(),
                ),
              ])),
        ));
  }

  void _handleLogIn(
      BuildContext context, Response response, String accessToken) {
    String? auxToken = accessToken;
    Map<String, dynamic> ap = json.decode(response.body);
    //Map<String, dynamic> ap = await uapi.logInGoogle(googleSignInAuthentication.accessToken.toString());
    if (response.statusCode == 200) {
      print("login:la cuanta  existe y voy a login correctamente");
      Navigator.of(context).pushNamed('/home');
    } else if (response.statusCode == 400) {
      print('status code : ' + response.statusCode.toString());
      print('error_message: ' + json.decode(response.body)['error_message']);
      String errorMessage = json.decode(response.body)['error_message'];
      if (errorMessage == "User does not exist") {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text("User does not exist"),
            content: const Text("Do you want to sign up now?"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    //GoogleSignInApi.logout();
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: const Text("Ok")),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("cancel")),
            ],
          ),
        );
      } else if (errorMessage ==
          "Authentication method not available for this email") {
        print("estoy aqui");
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text(
                "Authentication method not available for this email, existe account with this email"),
            content:
                const Text("Do you want to connect the account of SocialOut?"),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LinkScreen("", "", "google", auxToken)),
                      (route) => false),
                  //Navigator.of(context).pushNamed('/welcome'),
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("No")),
            ],
          ),
        );
        //Navigator.of(context).pushNamed('/login');

      } else if (errorMessage == "Google token was invalid") {
        Navigator.of(context).pushNamed('/login');
      }
    } else {
      print("Undefined Error");
    }
  }

  Future<void> _handleLoginGoogle(BuildContext context) async {
    try {
      final user = await GoogleSignInApi.login();

      if (user == null) {
        Navigator.of(context).pushNamed('/welcome');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sign in Failed, please try again')));
      } else {
        GoogleSignInAuthentication googleSignInAuthentication =
            await user.authentication;

        print(googleSignInAuthentication.accessToken);
        //https://www.googleapis.com/oauth2/v3/userinfo?access_token=googleSignInAuthentication.accessToken
        //https://www.googleapis.com/oauth2/v3/userinfo?access_token=ya29.A0ARrdaM-Uo5BGubza4xGpXK0JuFiAATuEHI_5UXjx-CWGtddi0Q_Qg6HxX-mRoNzKeQTc1ZyNs4JdwacIzGdSNQnzUlSyCfP3AVpK2OMaQcbqPcT3eM_4wSZSyKaYwIxhCZhI5zkLAtpCgHZj-XQ1vKUaOTrh
        print(" ");
        //we can decode with this idtoken
        print(googleSignInAuthentication.idToken);
        Response response = await uapi
            .logInGoogle(googleSignInAuthentication.accessToken.toString());
        _handleLogIn(
            context, response, googleSignInAuthentication.accessToken!);
        GoogleSignInApi.logout();
        //Navigator.of(context).pushNamed('/home');

        /*
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoggedInPage(
            user: user,
          ),
        )
        );
        */
      }
    } catch (error) {
      print(error);
    }
  }
}
