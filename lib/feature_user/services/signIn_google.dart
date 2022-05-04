import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:so_frontend/feature_user/screens/loggedIn_screen.dart';

class GoogleSignInApi {
  //static final _clientID = '66737086171-2qao8l71itbh358cj1hqqbe5ughhjqun.apps.googleusercontent.com';
  static final _googleSignIn = GoogleSignIn(clientId: _clientIDWeb);
  static final _clientIDWeb = '66737086171-n8tcu6ru19jja2sevcs99stj2ff2dn6g.apps.googleusercontent.com';
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
  //https://accounts.google.com/o/oauth2/auth?scope=https://www.googleapis.com/auth/androidpublisher&response_type=code&access_type=offline&redirect_uri=http://localhost:8080&client_id=66737086171-n8tcu6ru19jja2sevcs99stj2ff2dn6g.apps.googleusercontent.com
  //http://localhost:8080
  //https://socialout-develop.herokuapp.com
  //66737086171-n8tcu6ru19jja2sevcs99stj2ff2dn6g.apps.googleusercontent.com
  static Future logout() => _googleSignIn.disconnect();
  static Future logout2() => _googleSignIn.signOut();

  
  
  Future<void> _handleSignIn(BuildContext context) async {
    try {
      final user = await GoogleSignInApi.login();
      
      if(user == null){
        
        Navigator.of(context).pushNamed('/welcome');
        ScaffoldMessenger.of(context).showSnackBar(
          
          const SnackBar(
            content: 
            Text('Sign in Failed, please try again')
            )
          );
      }else{
        
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context)=> LoggedInPage(user: user,),
          ));
      }
    }
     catch ( error) {
      
      print(error);
    }
  }
}