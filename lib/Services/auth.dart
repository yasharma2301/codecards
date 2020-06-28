import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class FacebookAuth {
  bool _isLoggedIn = false;
  Map userProfile = {};
  final fbLogin = FacebookLogin();

  Future<void> login() async {
    final result = await fbLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token');
        final profile = JSON.jsonDecode(graphResponse.body);
        print('\x1B[94m');
        print(profile);
        print('\x1B[0m');
        userProfile = profile;
        _isLoggedIn = true;
        break;

      case FacebookLoginStatus.cancelledByUser:
        _isLoggedIn = false;
        break;

      case FacebookLoginStatus.error:
        print(result.errorMessage);
        _isLoggedIn = false;
        break;
    }
  }

  // Future<void> logout() {
  //   fbLogin.logOut();
  //   _isLoggedIn = false;
  // }
}

class GoogleAuth {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );
  GoogleSignInAccount _currentUser;

  Future<void> handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
        print(account);
        _currentUser = account;
        print(_currentUser);
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> handleSignOut() async {
    print("Good Bye");
    await _googleSignIn.disconnect();
  }
}
