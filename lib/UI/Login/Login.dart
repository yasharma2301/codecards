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
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Color(0xFF737373).withOpacity(0.9).withAlpha(70),
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [LightPopBlue, PopBlue],
                  stops: [0.52, 0.9],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  tileMode: TileMode.repeated),
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          height: screenHeight * 0.3,
          child: SignUpStack()),
    );
  }
}
