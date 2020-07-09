import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/Shared/delayed_animation.dart';
import 'package:codecards/UI/OnBoard/onBoardNew.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  double _height, _width;
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        return Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => OnBoardNew()));
      },
      child: Scaffold(
        backgroundColor: Grey,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/codecards.png",
                      height: _height / 5,
                      width: _width,
                    ),
                  ),
                  Text(
                    'Login To Your Account',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: LightGrey.withOpacity(0.7),
                      ),
                      child: TextFormField(
                        style: TextStyle(
                          color: White.withOpacity(0.7),
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Username",
                            hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 16)),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 20, top: 7, bottom: 7, right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: LightGrey.withOpacity(0.7),
                      ),
                      child: TextFormField(
                        obscureText: passwordVisible,
                        style: TextStyle(
                          color: White.withOpacity(0.7),
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              splashColor: Colors.transparent,
                              icon: Icon(
                                passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                            border: InputBorder.none,
                            hintText: "Enter Password",
                            hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 16)),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.6), fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),



                  // Clipped button here

                  

                  Divider(
                    color: Colors.transparent,
                    height: 40,
                  ),
                  Container(
                      width: _width,
                      height: 55,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent[200],
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: FlatButton(
                          color: Colors.transparent,
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.facebook,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: _width / 5,
                              ),
                              Text(
                                "Connect with Facebook",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ))),
                  Divider(
                    color: Colors.transparent,
                    height: 15,
                  ),
                  Container(
                      width: _width,
                      height: 55,
                      decoration: BoxDecoration(
                          color: Color(0xfff95a5f),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: FlatButton(
                          color: Colors.transparent,
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.google,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: _width / 5,
                              ),
                              Text(
                                "Connect with Google",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ))),
                  Divider(
                    color: Colors.transparent,
                    height: 15,
                  ),
                  Container(
                      width: _width,
                      height: 55,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[600],
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: FlatButton(
                          color: Colors.transparent,
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.github,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: _width / 5,
                              ),
                              Text(
                                "Connect with Github",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
