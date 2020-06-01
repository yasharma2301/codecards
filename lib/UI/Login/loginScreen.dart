import 'package:codecards/UI/Login/SignUpStack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:codecards/Shared/Colors.dart';
import 'SignUpStack.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flare_flutter/flare_actor.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Grey,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: screenHeight * 0.55,
              child: Center(
                child: Container(
                    height: 300,
                    width: 500,
                    child: FlareActor(
                      "assets/login_animation1.flr",
                      fit: BoxFit.contain,
                      animation: 'Scale',
                    )),
              ),
            ),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [LightPopBlue,PopBlue],
                          stops: [0.52, 0.9],
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          tileMode: TileMode.repeated),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  height: screenHeight * 0.3,
                  child: SignUpStack()),
            ),
          ],
        ),
      ),
    );
  }
}
