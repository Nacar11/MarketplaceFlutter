// ignore_for_file: file_names

import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignAPI {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future logout() => _googleSignIn.disconnect();
}
