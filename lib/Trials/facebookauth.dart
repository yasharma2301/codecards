import 'dart:convert';

import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:convert' as JSON;
import 'package:http/http.dart' as http;
import 'package:codecards/Services/auth.dart';

class FBAuth extends StatefulWidget {
  @override
  _FBAuthState createState() => _FBAuthState();
}

class _FBAuthState extends State<FBAuth> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  Future<Null> _login() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        print('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${accessToken.token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        // json.decode(graphResponse.body);
        print(profile);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }


  FacebookAuth fb = FacebookAuth();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Facebook Auth Try"),
            backgroundColor: Blue,
            centerTitle: true,
          ),
          backgroundColor: White,
          body: Center(
            child: RaisedButton(
              onPressed: () async {
                _login();
              },
              color: Blue,
              child: Text("Login with Facebook",
                  style: TextStyle(color: White, fontSize: 20)),
            ),
          )),
    );
  }
}
