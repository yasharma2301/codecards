import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class FacebookAuth {
  bool _isLoggedIn = false;
  Map userProfile = {};
  final fbLogin = FacebookLogin();

  Future<void> _login() async {
    final result = await fbLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
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

  Future<void> _logout() {
    fbLogin.logOut();
    _isLoggedIn = false;
  }
}
