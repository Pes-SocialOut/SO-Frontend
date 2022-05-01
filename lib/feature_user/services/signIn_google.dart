import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _clientID = '66737086171-2qao8l71itbh358cj1hqqbe5ughhjqun.apps.googleusercontent.com';
  static final _googleSignIn = GoogleSignIn();
  
  static Future<GoogleSignInAccount?> signin() => _googleSignIn.signIn();
  
  static Future logout() => _googleSignIn.disconnect();

  
}