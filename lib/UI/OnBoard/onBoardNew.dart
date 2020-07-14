import 'dart:io';
import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/Shared/delayed_animation.dart';
import 'package:codecards/Shared/fade_animation.dart';
import 'package:codecards/UI/Login/newLoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class OnBoardNew extends StatefulWidget {
  @override
  _OnBoardNewState createState() => _OnBoardNewState();
}

class _OnBoardNewState extends State<OnBoardNew> with TickerProviderStateMixin {
  AnimationController _scaleController;
  AnimationController _scale2Controller;
  AnimationController _widthController;
  AnimationController _positionController;
  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;
  Animation<double> _widthAnimation;
  Animation<double> _positionAnimation;
  bool hideIcon = false;

  @override
  void initState() {
    super.initState();

    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _widthController.forward();
            }
          });

    _widthController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    _widthAnimation =
        Tween<double>(begin: 80.0, end: 300.0).animate(_widthController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _positionController.forward();
            }
          });

    _positionController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _positionAnimation =
        Tween<double>(begin: 0.0, end: 215.0).animate(_positionController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                hideIcon = true;
              });
              _scale2Controller.forward();
            }
          });

    _scale2Controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 220));

    _scale2Animation =
        Tween<double>(begin: 1.0, end: 32.0).animate(_scale2Controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: RegisterPage()));
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        exit(0);
        return;
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(9, 14, 23, 1),
        body: Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -50,
                left: 0,
                child: FadeAnimation(
                  1,
                  Container(
                    width: width,
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/background.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -100,
                left: 0,
                child: FadeAnimation(
                  1.3,
                  Container(
                    width: width,
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/background.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -150,
                left: 0,
                child: FadeAnimation(
                  1.6,
                  Container(
                    width: width,
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/background.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                      1,
                      Text(
                        "Welcome",
                        style: TextStyle(color: Colors.white, fontSize: 50),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    FadeAnimation(
                        1.3,
                        Text(
                          "We are happy to see you here!\nJust a few steps and we'll get into the server.",
                          style: TextStyle(
                              color: Colors.white.withOpacity(.7),
                              height: 1.4,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        )),
                    SizedBox(
                      height: 180,
                    ),
                    DelayedAnimation(
                      delay: 550,
                      child: AnimatedBuilder(
                        animation: _scaleController,
                        builder: (context, child) => Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Center(
                            child: AnimatedBuilder(
                              animation: _widthController,
                              builder: (context, child) => Container(
                                width: _widthAnimation.value,
                                height: 80,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: LightGrey.withOpacity(0.8)),
                                child: GestureDetector(
                                  onTap: () {
                                    _scaleController.forward();
                                  },
                                  child: Stack(
                                    children: <Widget>[
                                      AnimatedBuilder(
                                        animation: _positionController,
                                        builder: (context, child) => Positioned(
                                          left: _positionAnimation.value,
                                          child: AnimatedBuilder(
                                            animation: _scale2Controller,
                                            builder: (context, child) =>
                                                Transform.scale(
                                              scale: _scale2Animation.value,
                                              child: Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Grey),
                                                child: hideIcon == false
                                                    ? Icon(
                                                        Icons.arrow_forward,
                                                        color: Colors.white,
                                                      )
                                                    : Container(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
