import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi{
  static final _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
  
  static Future logout() => _googleSignIn.disconnect();
}