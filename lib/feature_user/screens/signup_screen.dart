// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:so_frontend/feature_user/screens/link_user.dart';
import 'package:so_frontend/feature_user/services/signIn_facebook.dart';
import 'package:so_frontend/feature_user/services/signIn_google.dart';
import 'package:so_frontend/feature_user/widgets/policy.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:so_frontend/feature_user/services/login_signUp.dart';
import 'package:so_frontend/utils/go_to.dart';

import 'form_register_CS.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final userAPI uapi = userAPI();
  @override
  Widget build(BuildContext context) {
    double borderradius = 10.0;
    double policyTextSize = 14;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0x00c8c8c8),
          title: const Text('register').tr(),
          leading: IconButton(
            iconSize: 24,
            color: Theme.of(context).colorScheme.onSurface,
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
            onPressed: () {
              Navigator.of(context).pushNamed('/welcome');
            },
          ),
        ),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(children: <Widget>[
                const SizedBox(height: 60),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: SignInButton(
                    Buttons.Google,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderradius)),
                    text: "ContinuewithGoogle".tr(),
                    onPressed: () => _handleSignInGoogle(
                        context), //{print("object"); FacebookSignInApi.logout2();}
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: SignInButton(
                    Buttons.Facebook,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderradius)),
                    text: "ContinuewithFacebook".tr(),
                    onPressed: () => _handleSignInFacebook(context),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "or",
                    style: TextStyle(color: Colors.black45, fontSize: 16),
                  ).tr(),
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: SignInButton(
                    Buttons.Email,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderradius)),
                    text: "ContinuewithEmail".tr(),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/register');
                    },
                  ),
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
                          text: "Alreadyhaveanaccount".tr()),
                      TextSpan(
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: policyTextSize),
                          text: "login".tr(),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacementNamed(context, '/new_route', arguments: GoTo(
                                () => Navigator.pushNamed(context, '/home')
                              ));
                              //cant launch at the moment, because emualtor has no internet
                              /*
                          if(await canLaunchUrl(url)){
                            await launchUrl(url);
                          }
                          else{
                            throw "cannot load Url";
                          }
                          */
                            }),
                    ]),
                  ),
                ),
                const SizedBox(height: 60),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const PolicyWidget(),
                ),
              ])),
        ));
  }

  void _handleSignUpGoogle(BuildContext context, Response response,
      GoogleSignInAuthentication googleSignInAuthentication) {
    String auxToken = googleSignInAuthentication.accessToken.toString();
    if (response.statusCode == 200) {
      Map<String, dynamic> ap = json.decode(response.body);
      //Map<String, dynamic> ap = await uapi.checkUserGoogle(googleSignInAuthentication.accessToken);
      if (ap["action"] == "continue") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => FormRegisterCS(auxToken, "google")),
            (route) => false);
        GoogleSignInApi.logout2();
      } else if (ap["action"] == "error") {
        GoogleSignInApi.logout2();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text("Userexists").tr(),
            content: Text("wantLogin").tr(),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/login', arguments: GoTo(
                    () => Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false)
                  )),
                  child: Text("Yes").tr()),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("No").tr()),
            ],
          ),
        );
      } else if (ap["action"] == "link_auth") {
        GoogleSignInApi.logout2();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text("UserexistsSocialOut").tr(),
            content: Text("LinkSocialOut").tr(),
            actions: <Widget>[
              TextButton(
                  onPressed: () => {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LinkScreen(
                          "", "", "google", auxToken.toString())),
                      (route) => false)
                  },
                  child: Text("Yes").tr()),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("No".tr())),
            ],
          ),
        );
      }
    } else if (response.statusCode == 400) {
      String errorMessage = json.decode(response.body)['error_message'];
      if (errorMessage ==
          "Authentication method not available for this email") {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text("methodnotavailableemail").tr(),
            content: Text("LinkSocialOut").tr(),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LinkScreen(
                              "", "", "google", auxToken.toString())),
                      (route) => false),
                  //Navigator.of(context).pushNamed('/welcome'),
                  child: Text("Yes").tr()),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("No").tr()),
            ],
          ),
        );
        Navigator.pushNamed(context, '/login', arguments: GoTo(
          () => Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false)
        ));
      } else if (errorMessage == "Google token was invalid") {
        Navigator.pushNamed(context, '/login', arguments: GoTo(
          () => Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false)
        ));
      }
    }
  }

  void _handleSignUpFacebook(
      BuildContext context, Response response, String accessToken) {
    if (response.statusCode == 200) {
      Map<String, dynamic> ap = json.decode(response.body);
      if (ap["action"] == "continue") {
        FacebookSignInApi.logout();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => FormRegisterCS(accessToken, "facebook")),
            (route) => false);
        FacebookSignInApi.logout();
      } else if (ap["action"] == "error") {
        FacebookSignInApi.logout();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text("Userexists").tr(),
            content: Text("wantLogin").tr(),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/login', arguments: GoTo(
                    () => Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false)
                  )),
                  child: Text("Yes").tr()),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("No").tr()),
            ],
          ),
        );
      } else if (ap["action"] == "link_auth") {
        FacebookSignInApi.logout();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text("UserexistsSocialOut").tr(),
            content: Text("LinkSocialOut").tr(),
            actions: <Widget>[
              TextButton(
                  onPressed: () => {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LinkScreen(
                                    "", "", "facebook", accessToken)),
                            (route) => false),
                      },
                  child: Text("Yes").tr()),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("No").tr()),
            ],
          ),
        );
      }
    } else if (response.statusCode == 400) {
      String errorMessage = json.decode(response.body)['error_message'];
      if (errorMessage ==
          "Authentication method not available for this email") {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text("methodnotavailableemail").tr(),
            content: Text("LinkSocialOut").tr(),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LinkScreen("", "", "facebook", accessToken)),
                      (route) => false),
                  child: Text("Yes").tr()),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("No").tr()),
            ],
          ),
        );
      } else if (errorMessage == "Facebook token was invalid") {
        Navigator.of(context).pushNamed('/signup');
      }
    } else {
      /* print('status code : ' + response.statusCode.toString());
      print('error_message: ' + json.decode(response.body)['error_message']);
      print("Undefined Error"); */
    }
  }

  Future<void> _handleSignInGoogle(BuildContext context) async {
    try {
      final user = await GoogleSignInApi.login();

      if (user == null) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text('SignupFailed').tr(),
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

        //https://www.googleapis.com/oauth2/v3/userinfo?access_token=googleSignInAuthentication.accessToken
        //https://www.googleapis.com/oauth2/v3/userinfo?access_token=ya29.A0ARrdaM-Uo5BGubza4xGpXK0JuFiAATuEHI_5UXjx-CWGtddi0Q_Qg6HxX-mRoNzKeQTc1ZyNs4JdwacIzGdSNQnzUlSyCfP3AVpK2OMaQcbqPcT3eM_4wSZSyKaYwIxhCZhI5zkLAtpCgHZj-XQ1vKUaOTrh

        //we can decode with this idtoken
        //print(googleSignInAuthentication.idToken);

        Response response =
            await uapi.checkUserGoogle(googleSignInAuthentication.accessToken);
        _handleSignUpGoogle(context, response, googleSignInAuthentication);

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

  Future<void> _handleSignInFacebook(BuildContext context) async {
    try {
      final LoginResult result =
          await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
      if (result.status == LoginStatus.success) {
        final accessTokenFacebook = result.accessToken?.token.toString();

        Response response = await uapi.checkUserFacebook(accessTokenFacebook);
        _handleSignUpFacebook(context, response, accessTokenFacebook!);
      } else {
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
      }
    } catch (error) {
      //print(error);
    }
  }
}
