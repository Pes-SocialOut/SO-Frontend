import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:so_frontend/feature_explore/screens/home.dart';
import 'package:so_frontend/feature_user/screens/form_register_CS.dart';
import 'package:so_frontend/feature_user/services/logIn_signUp.dart';
import 'package:so_frontend/feature_user/widgets/policy.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/signIn_google.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
  final userAPI uapi = userAPI();
  @override
  Widget build(BuildContext context) {
    double borderradius = 10.0;
    double widthButton = 300.0;
    double heightButton = 40.0;
    double policyTextSize = 14;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xC8C8C8),
            title: const Text('Hello Agian!')),
        body: Center(
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
                        hintText: "Enter email", labelText: "Username"),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: "Enter password", labelText: "Password"),
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
                    onPressed: () {
                      Navigator.of(context).pushNamed('/home');
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
                const SizedBox(height: 50),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const PolicyWidget(),
                ),
              ])),
        ));
  }

  void _handleLogIn(BuildContext context, Response response ){
    Map<String, dynamic> ap = json.decode(response.body);
        //Map<String, dynamic> ap = await uapi.logInGoogle(googleSignInAuthentication.accessToken.toString());
        if (response.statusCode == 200) {
          print("login:la cuanta  existe y voy a login correctamente");
          Navigator.of(context).pushNamed('/home');

        } else if(response.statusCode == 400) {
          print('status code : ' + response.statusCode.toString());
          print('error_message: ' + json.decode(response.body)['error_message']);
          String errorMessage = json.decode(response.body)['error_message'];
          if(errorMessage == "User does not exist"){
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: const Text("User does not exist"),
                content:
                    const Text("Do you want to sign up now?"),
                actions: <Widget>[
                  TextButton(
                      onPressed: () 
                          {
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
          }
          else if(errorMessage == "Authentication method not available for this email"){
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: const Text("cancel subscription"),
                content:
                    const Text("want to cancel the subscription?"),
                actions: <Widget>[
                  TextButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/welcome'),
                      child: const Text("Ok")),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("cancel")),
                ],
              ),
            );
            Navigator.of(context).pushNamed('/login');

          }
          else if(errorMessage == "Google token was invalid"){
            Navigator.of(context).pushNamed('/login');
          }
          
        }
        else {
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
        Response response = await uapi.logInGoogle(googleSignInAuthentication.accessToken.toString());
        _handleLogIn( context, response);
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
