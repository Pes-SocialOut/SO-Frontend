// ignore_for_file: file_names

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FacebookSignInApi {
  //static final _clientID = '66737086171-2qao8l71itbh358cj1hqqbe5ughhjqun.apps.googleusercontent.com';
  static final _googleSignIn = GoogleSignIn(clientId: _clientIDWeb);
  static const _clientIDWeb = '66737086171-n8tcu6ru19jja2sevcs99stj2ff2dn6g.apps.googleusercontent.com';
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
  //https://accounts.google.com/o/oauth2/auth?scope=https://www.googleapis.com/auth/androidpublisher&response_type=code&access_type=offline&redirect_uri=http://localhost:8080&client_id=66737086171-n8tcu6ru19jja2sevcs99stj2ff2dn6g.apps.googleusercontent.com
  //http://localhost:8080
  //https://socialout-develop.herokuapp.com
  //66737086171-n8tcu6ru19jja2sevcs99stj2ff2dn6g.apps.googleusercontent.com
  static Future logout() => _googleSignIn.disconnect();
  static Future logout2() => FacebookAuth.instance.logOut();
  
  
  
}