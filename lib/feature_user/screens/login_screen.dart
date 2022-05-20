import 'dart:convert';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:so_frontend/feature_user/screens/link_user.dart';
import 'package:so_frontend/feature_user/services/login_signUp.dart';
import 'package:so_frontend/feature_user/services/signIn_facebook.dart';
import 'package:so_frontend/feature_user/widgets/policy.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../services/signIn_google.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final userAPI uapi = userAPI();
  late String email;
  late String password;
  late String verification;
  late String newPassword;
  late String codeVerification;
  double borderradius = 10.0;
  double widthButton = 300.0;
  double heightButton = 40.0;
  double policyTextSize = 14;
  bool incorrectPassword = false;
  bool incorrectCodeVerification = false;
  bool google = false;
  bool facebook = false;
  bool googFace = false;
  late String message;

  Widget crearMensajeError(String type, String mensaje) {
    if (type == "googFace") {
      setState(() {
        incorrectCodeVerification = false;
        google = false;
        facebook = false;
      });
    } else if (type == "google") {
      setState(() {
        incorrectCodeVerification = false;
        googFace = false;
        facebook = false;
      });
    } else if (type == "facebook") {
      setState(() {
        incorrectCodeVerification = false;
        googFace = false;
        google = false;
      });
    } else if (type == "incorrectCodeVerification") {
      setState(() {
        facebook = false;
        googFace = false;
        google = false;
      });
    }
    return Center(
      child: Text(
        mensaje,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0x00c8c8c8),
            title: const Text('Hello Again!')),
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
                    onPressed: () => _handleLoginFacebook(context),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: formKey3,
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
                if (incorrectPassword)
                  crearMensajeError("incorrectPassword", message),
                if (google) crearMensajeError("google", message),
                if (facebook) crearMensajeError("facebook", message),
                if (googFace) crearMensajeError("googFace", message),
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
                      if (formKey3.currentState!.validate() &
                          formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        formKey3.currentState!.save();
                        Map<String, dynamic> ap =
                            await uapi.checkloginSocialOut(email);
                        if (ap["action"] == "continue") {
                          int aux = await uapi.loginSocialOut(email, password);
                          if (aux == 200) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/home', (route) => false);
                          } else if (aux == 400) {
                            setState(() {
                              incorrectPassword = true;
                              message = "Incorrect Password";
                            });
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
                //FORGET PASSWORD?
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
                        if (formKey3.currentState!.validate()) {
                          formKey3.currentState!.save();
                          print(email);
                          Map<String, dynamic> aux =
                              await uapi.checkEmailForNewPassword(email);
                          if (aux["action"] == "continue") {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => AlertDialog(
                                title:
                                    const Text("We send a code to your email"),
                                content: Form(
                                  key: formKey2,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TextFormField(
                                        decoration: const InputDecoration(
                                          labelText: "New Password",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(29))),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "a password is required";
                                          } else {
                                            RegExp regex = RegExp(
                                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
                                            if (!regex.hasMatch(value)) {
                                              return 'min 8 caracters(numeric,UpperCase,LowerCase)';
                                            } else {
                                              return null;
                                            }
                                          }
                                        },
                                        onSaved: (value) {
                                          newPassword = value.toString();
                                        },
                                      ),
                                      const SizedBox(height: 15),
                                      TextFormField(
                                        decoration: const InputDecoration(
                                          labelText: "Verification Code",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(29))),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter verification code';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          codeVerification = value.toString();
                                        },
                                      ),
                                      incorrectCodeVerification
                                          ? const Text(
                                              "error code verification",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          : const Text("welcome"),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 30),
                                    child: TextButton(
                                      onPressed: () async {
                                        if (formKey2.currentState!.validate()) {
                                          formKey2.currentState!.save();
                                          int ap =
                                              await uapi.finalPasswordRecovery(
                                                  email,
                                                  newPassword,
                                                  codeVerification);
                                          print("statusCode" + ap.toString());
                                          if (ap == 200) {
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    '/home', (route) => false);
                                          } else if (ap == 403) {
                                            print("ENTRO A IF ap == 403");
                                            super.reassemble();
                                            super.setState(() {
                                              incorrectCodeVerification = true;
                                              print(
                                                  "INCORRECTCODEVERIFITACION=TRUE");
                                            });
                                          }
                                        }
                                      },
                                      child: const Text(
                                        "Ok",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 30,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40, right: 8),
                                    child: TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 15,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (aux["action"] == "no_auth") {
                            if (aux["alternative_auths"]
                                .contains("google", "facebook")) {
                              setState(() {
                                message = "google and facebook registered";
                                incorrectPassword = true;
                              });
                            } else if (aux["alternative_auths"]
                                .contains("google")) {
                              setState(() {
                                message = "google registered";
                                incorrectPassword = true;
                              });
                            } else {
                              setState(() {
                                message = "facebook registered";
                                incorrectPassword = true;
                              });
                            }
                          }
                        }
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

  void _handleLogIn(BuildContext context, Response response, String accessToken,
      String type) {
    String? auxToken = accessToken;
    if (response.statusCode == 200) {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    } else if (response.statusCode == 400) {
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
                    if (type == "google") GoogleSignInApi.logout2();
                    if (type == "facebook") FacebookSignInApi.logout();
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
                  onPressed: () => {
                        if (type == "google")
                          {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LinkScreen("", "", "google", auxToken)),
                                (route) => false),
                          }
                        else if (type == "facebook")
                          {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LinkScreen(
                                        "", "", "facebook", auxToken)),
                                (route) => false),
                          }
                      },
                  //Navigator.of(context).pushNamed('/welcome'),
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("No")),
            ],
          ),
        );
        //Navigator.of(context).pushNamed('/login');

      } else if (errorMessage == "Google token was invalid" ||
          errorMessage == "Facebook token was invalid") {
        Navigator.of(context).pushNamed('/login');
      }
    }
  }

  Future<void> _handleLoginGoogle(BuildContext context) async {
    try {
      final user = await GoogleSignInApi.login();

      if (user == null) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Sign in Failed'),
            content: const Text("Please try again"),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Ok")),
            ],
          ),
        );
      } else {
        GoogleSignInAuthentication googleSignInAuthentication =
            await user.authentication;
        Response response = await uapi
            .logInGoogle(googleSignInAuthentication.accessToken.toString());
        _handleLogIn(context, response,
            googleSignInAuthentication.accessToken.toString(), "google");
        GoogleSignInApi.logout2();
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
      //print(error);
    }
  }

  Future<void> _handleLoginFacebook(BuildContext context) async {
    try {
      final LoginResult result =
          await FacebookAuth.i.login(permissions: ['public_profile', 'email']);

      if (result.status == LoginStatus.success) {
        final accessTokenFacebook = result.accessToken?.token.toString();
        Response response =
            await uapi.logInFacebook(accessTokenFacebook.toString());
        _handleLogIn(
            context, response, accessTokenFacebook.toString(), "facebook");
        FacebookSignInApi.logout();
      } else {}
      FacebookSignInApi.logout();
    } catch (error) {
      //print(error);
    }
  }
}
