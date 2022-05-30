// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:so_frontend/feature_user/screens/link_user.dart';
import 'package:so_frontend/feature_user/services/login_signUp.dart';
import 'package:so_frontend/feature_user/services/signIn_facebook.dart';
import 'package:so_frontend/feature_user/widgets/policy.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
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
  bool google = false;
  bool facebook = false;
  bool googFace = false;
  late String message;
  String mensaje2 = "";

  Widget crearMensajeError(String mensaje) {
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
          title: Text('hello').tr(),
          leading: IconButton(
            iconSize: 24,
            color: Theme.of(context).colorScheme.onSurface,
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
            onPressed: () {
              Navigator.of(context).pushNamed('/welcome');
            },
          ),
        ),
        body: Form(
          key: formKey,
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(children: <Widget>[
                // LOGIN WITH GOOGLE
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                  child: SignInButton(
                    Buttons.Google,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderradius)),
                    text: "LoginwithGoogle".tr(),
                    onPressed: () => _handleLoginGoogle(context),
                  ),
                ),
                // LOGIN WITH FACEBOOK
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: SignInButton(
                    Buttons.Facebook,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderradius)),
                    text: "LoginwithFacebook".tr(),
                    onPressed: () => _handleLoginFacebook(context),
                  ),
                ),
                // EMAIL
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: formKey3,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Enteremail".tr(), labelText: "Email".tr()),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return "validemail".tr();
                        }
                        return null;
                      },
                      onSaved: (value) {
                        email = value.toString();
                      },
                    ),
                  ),
                ),
                // PASSWORD
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enterpassword".tr(),
                      labelText: "Password".tr(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "passwordrequired".tr();
                      } else {
                        RegExp regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
                        if (!regex.hasMatch(value)) {
                          return 'validpassword'.tr();
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
                if (incorrectPassword) crearMensajeError(message),
                //BUTTON LOG IN
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
                              message = "IncorrectPassword".tr();
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
                              title: Text("FailLogin").tr(),
                              content: Text("Accountdoesnotexist").tr(),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text("Ok").tr(),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    },
                    child: Text(
                      'login',
                      style: TextStyle(
                          height: 1.0,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ).tr(),
                  ),
                ),
                //FORGET PASSWORD?
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                      child: Text(
                        'Forgetpassword',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: policyTextSize),
                      ).tr(),
                      onTap: () async {
                        if (formKey3.currentState!.validate()) {
                          formKey3.currentState!.save();
                          Map<String, dynamic> aux =
                              await uapi.checkEmailForNewPassword(email);
                          if (aux["action"] == "continue") {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => AlertDialog(
                                title: Text("sendcode").tr(),
                                content: StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter cambiarEstado) {
                                  return Form(
                                    key: formKey2,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          TextFormField(
                                            decoration: InputDecoration(
                                              labelText: "NewPassword".tr(),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(29))),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "passwordrequired".tr();
                                              } else {
                                                RegExp regex = RegExp(
                                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
                                                if (!regex.hasMatch(value)) {
                                                  return 'validpass2'.tr();
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
                                            decoration: InputDecoration(
                                              labelText:
                                                  "VerificationCode".tr(),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(29))),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'enterVeriCode'.tr();
                                              }
                                              return null;
                                            },
                                            onSaved: (value) {
                                              codeVerification =
                                                  value.toString();
                                            },
                                          ),
                                          Text(
                                            mensaje2,
                                            style: const TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextButton(
                                                onPressed: () async {
                                                  if (formKey2.currentState!
                                                      .validate()) {
                                                    formKey2.currentState!
                                                        .save();
                                                    int ap = await uapi
                                                        .finalPasswordRecovery(
                                                            email,
                                                            newPassword,
                                                            codeVerification);
                                                    if (ap == 200) {
                                                      Navigator.of(context)
                                                          .pushNamedAndRemoveUntil(
                                                              '/home',
                                                              (route) => false);
                                                    } else if (ap == 403) {
                                                      cambiarEstado(() {
                                                        mensaje2 =
                                                            "incorrectVeriCode"
                                                                .tr();
                                                      });
                                                    }
                                                  }
                                                },
                                                child: Text(
                                                  "Ok".tr(),
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 30,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    incorrectPassword = false;
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  "Cancel".tr(),
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            );
                          } else if (aux["action"] == "no_auth") {
                            if (aux["alternative_auths"].contains("facebook") &&
                                aux["alternative_auths"].contains("google")) {
                              setState(() {
                                message = "gooFaceRegister".tr();
                                incorrectPassword = true;
                              });
                            } else if (aux["alternative_auths"]
                                .contains("google")) {
                              setState(() {
                                message = "googRegis".tr();
                                incorrectPassword = true;
                              });
                            } else {
                              setState(() {
                                message = "faceRegis".tr();
                                incorrectPassword = true;
                              });
                            }
                          } else {
                            setState(() {
                              message = "Emailnotfound".tr();
                              incorrectPassword = true;
                            });
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
                          text: "noAccount".tr()),
                      TextSpan(
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: policyTextSize),
                          text: "signUp".tr(),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushNamed('/signup');
                            }),
                    ]),
                  ),
                ),
                const SizedBox(height: 30),
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
            title: Text("userNotExist").tr(),
            content: Text("wantSign").tr(),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    if (type == "google") GoogleSignInApi.logout2();
                    if (type == "facebook") FacebookSignInApi.logout();
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: Text("Ok").tr()),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Cancel").tr()),
            ],
          ),
        );
      } else if (errorMessage ==
          "Authentication method not available for this email") {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text("authNotExistAccount").tr(),
            content: Text("wantConnec").tr(),
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
                  child: Text("Yes").tr()),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("No").tr()),
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
            title: Text('SigninFailed').tr(),
            content: Text("tryAgain").tr(),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Ok").tr()),
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
