import 'package:codecards/Services/GithubAuth/GithubLogin.dart';
import 'package:codecards/UI/Login/SignUpStack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:codecards/Shared/Colors.dart';
import 'SignUpStack.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double screenHeight, screenWidth;

  @override
  void dispose() {
    GithubLogin().stream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [PopBlue, LightPopBlue],
                  stops: [0.52, 0.9],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  tileMode: TileMode.repeated),
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          height: 280,
          child: SignUpStack()),
    );
  }
}
