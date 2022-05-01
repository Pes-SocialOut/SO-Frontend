import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi{
  static final _googleSignIn = GoogleSignIn(clientId: "66737086171-2qao8l71itbh358cj1hqqbe5ughhjqun.apps.googleusercontent.com");
  
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
  
  static Future logout() => _googleSignIn.disconnect();
}