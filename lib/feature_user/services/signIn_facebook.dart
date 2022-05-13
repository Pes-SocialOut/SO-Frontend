// ignore_for_file: file_names

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignInApi {
  static Future logout2() => FacebookAuth.instance.logOut();
}