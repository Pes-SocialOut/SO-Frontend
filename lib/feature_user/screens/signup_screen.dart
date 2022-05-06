import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:so_frontend/feature_user/screens/link_user.dart';
import 'package:so_frontend/feature_user/services/signIn_google.dart';
import 'package:so_frontend/feature_user/widgets/policy.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:so_frontend/feature_user/services/login_signUp.dart';

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
            backgroundColor: const Color(0x00c8c8c8), title: const Text('Sign Up')),
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
                    text: "Continue with Google",
                    onPressed: () => _handleSignIn(context),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: SignInButton(
                    Buttons.Facebook,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderradius)),
                    text: "Continue with Facebook",
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "OR",
                    style: TextStyle(color: Colors.black45, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: SignInButton(
                    Buttons.Email,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderradius)),
                    text: "Continue with Email",
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
                          text: "Already have an account? "),
                      TextSpan(
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: policyTextSize),
                          text: "Log In",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushNamed('/login');
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

  void _handleSignUp(BuildContext context, Response response, GoogleSignInAuthentication googleSignInAuthentication){
    String auxToken =  googleSignInAuthentication.accessToken.toString();
    if(response.statusCode == 200){
      Map<String, dynamic>ap = json.decode(response.body);
      //Map<String, dynamic> ap = await uapi.checkUserGoogle(googleSignInAuthentication.accessToken);
      if (ap["action"] == "continue") {        
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    FormRegisterCS(auxToken.toString())),
            (route) => false);
            GoogleSignInApi.logout2();
      }
      else if(ap["action"] == "error"){
        
        GoogleSignInApi.logout2();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text("User with this email already exists"),
            content:
                const Text("Do you want to Log In?"),
            actions: <Widget>[
              TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/login'),
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("No")),
            ],
          ),
        );
      }
      else if(ap["action"] == "link_auth"){
        GoogleSignInApi.logout2();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text("User with this email already exists in SocialOut"),
            content:
                const Text("Do you want to Link with SocialOut?"),
            actions: <Widget>[
              TextButton(
                  onPressed: () =>{
                    Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LinkScreen("","","google",auxToken.toString() )),
                                  (route) => false),
                          //Navigator.of(context).pushNamed('/welcome'),
                      
                  },
                      //Navigator.of(context).pushNamed('/login'),
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("No")),
            ],
          ),
        );
      }
    }
    else if(response.statusCode == 400) {
      String errorMessage = json.decode(response.body)['error_message'];
      if(errorMessage == "Authentication method not available for this email"){
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text("Authentication method not available for this email, existe account with this email"),
            content:
                const Text("Do you want to connect the account of SocialOut?"),
            actions: <Widget>[
              TextButton(
                  onPressed: () =>
                  Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LinkScreen("","","google",auxToken.toString() )),
                              (route) => false),
                      //Navigator.of(context).pushNamed('/welcome'),
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("No")),
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
      /* print('status code : ' + response.statusCode.toString());
      print('error_message: ' + json.decode(response.body)['error_message']);
      print("Undefined Error"); */
    }
    
    /*
    Map<String, dynamic>ap = json.decode(response.body);
    //Map<String, dynamic> ap = await uapi.checkUserGoogle(googleSignInAuthentication.accessToken);
    if (ap["action"] == "continue") {
      print("la cuanta no existe");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  FormRegisterCS(googleSignInAuthentication.accessToken.toString())),
          (route) => false);
    } else {
      print("enlazar a cuenta ya existente");
    }
    */
  }

  Future<void> _handleSignIn(BuildContext context) async {
    try {
      final user = await GoogleSignInApi.login();

      if (user == null) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Sign up Failed'),
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
            
        //https://www.googleapis.com/oauth2/v3/userinfo?access_token=googleSignInAuthentication.accessToken
        //https://www.googleapis.com/oauth2/v3/userinfo?access_token=ya29.A0ARrdaM-Uo5BGubza4xGpXK0JuFiAATuEHI_5UXjx-CWGtddi0Q_Qg6HxX-mRoNzKeQTc1ZyNs4JdwacIzGdSNQnzUlSyCfP3AVpK2OMaQcbqPcT3eM_4wSZSyKaYwIxhCZhI5zkLAtpCgHZj-XQ1vKUaOTrh
        
        //we can decode with this idtoken
        //print(googleSignInAuthentication.idToken);

        Response response = await uapi.checkUserGoogle(googleSignInAuthentication.accessToken);
        _handleSignUp(context, response, googleSignInAuthentication);
        
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


}
