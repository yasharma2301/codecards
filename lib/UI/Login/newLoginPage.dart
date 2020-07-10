import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/Shared/delayed_animation.dart';
import 'package:codecards/UI/Login/newSocialButton.dart';
import 'package:codecards/UI/OnBoard/onBoardNew.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  double _height, _width;
  bool passwordVisible = true, passwordEmpty = true;
  TextEditingController _passwordContoller = TextEditingController();
  TextEditingController _emailContoller = TextEditingController();

  @override
  void dispose() {
    _passwordContoller.dispose();
    super.dispose();
  }

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
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 0,
                ),
                Image.asset(
                  "assets/codecards.png",
                  height: _height / 5,
                  width: _width,
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: LightGrey.withOpacity(0.7),
                  ),
                  child: TextFormField(
                    controller: _emailContoller,
                    style: TextStyle(
                      color: White.withOpacity(0.7),
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.person_outline,
                          color: Grey,
                        ),
                        border: InputBorder.none,
                        hintText: "Enter Email",
                        hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 16)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 07),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: LightGrey.withOpacity(0.7),
                  ),
                  child: TextFormField(
                    controller: _passwordContoller,
                    obscureText: passwordVisible,
                    style: TextStyle(
                      color: White.withOpacity(0.7),
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock_outline,
                          color: Grey,
                        ),
                        suffixIcon: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: passwordEmpty
                                ? Colors.transparent
                                : Colors.white.withOpacity(0.5),
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
                    onChanged: (value) {
                      if (value.length > 0) {
                        setState(() {
                          passwordEmpty = false;
                        });
                      } else {
                        setState(() {
                          passwordEmpty = true;
                        });
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: _width,
                  child: Text(
                    'Forgot password?',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: Colors.blueAccent.withOpacity(0.8),
                        fontSize: 17),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),

                // Clipped button here
                InkWell(
                  onTap: () => _login(context),
                  child: ClipPath(
                    clipper: LoginClipper(),
                    child: Container(
                      width: _width / 1.5,
                      height: _height / 12,
                      color: Color(0xFFF95A5F).withOpacity(0.8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(color: White, fontSize: 20),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.arrow_forward, color: White)
                        ],
                      ),
                    ),
                  ),
                ),

                Container(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: _width / 2.5,
                        height: 2,
                        color: White.withOpacity(0.4),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "OR",
                        style: TextStyle(color: White, fontSize: 16),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: _width / 2.5,
                        height: 2,
                        color: White.withOpacity(0.4),
                      ),
                    ],
                  ),
                ),
                // Container(
                //     width: _width,
                //     height: 55,
                //     decoration: BoxDecoration(
                //         color: Colors.blueAccent[200],
                //         borderRadius: BorderRadius.all(Radius.circular(5))),
                //     child: FlatButton(
                //         color: Colors.transparent,
                //         onPressed: () {},
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           children: <Widget>[
                //             Icon(
                //               FontAwesomeIcons.facebook,
                //               color: Colors.white,
                //             ),
                //             SizedBox(
                //               width: _width / 5,
                //             ),
                //             Text(
                //               "Connect with Facebook",
                //               style: TextStyle(color: Colors.white),
                //             ),
                //           ],
                //         ))),
                SocialButton2(
                  width: _width,
                  title: "Connect with Facebook",
                  icon: FontAwesomeIcons.facebook,
                  color: Colors.blueAccent[200],
                ),
                Divider(
                  color: Colors.transparent,
                  height: 15,
                ),
                // Container(
                //     width: _width,
                //     height: 55,
                //     decoration: BoxDecoration(
                //         color: Color(0xfff95a5f),
                //         borderRadius: BorderRadius.all(Radius.circular(5))),
                //     child: FlatButton(
                //         color: Colors.transparent,
                //         onPressed: () {},
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           children: <Widget>[
                //             Icon(
                //               FontAwesomeIcons.google,
                //               color: Colors.white,
                //             ),
                //             SizedBox(
                //               width: _width / 5,
                //             ),
                //             Text(
                //               "Connect with Google",
                //               style: TextStyle(color: Colors.white),
                //             ),
                //           ],
                //         ))),
                SocialButton2(
                  width: _width,
                  title: "Connect with Google",
                  icon: FontAwesomeIcons.google,
                  color: Color(0xFFF95A5F),
                ),
                Divider(
                  color: Colors.transparent,
                  height: 15,
                ),
                // Container(
                //     width: _width,
                //     height: 55,
                //     decoration: BoxDecoration(
                //         color: Colors.blueGrey[600],
                //         borderRadius: BorderRadius.all(Radius.circular(5))),
                //     child: FlatButton(
                //         color: Colors.transparent,
                //         onPressed: () {},
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           children: <Widget>[
                //             Icon(
                //               FontAwesomeIcons.github,
                //               color: Colors.white,
                //             ),
                //             SizedBox(
                //               width: _width / 5,
                //             ),
                //             Text(
                //               "Connect with Github",
                //               style: TextStyle(color: Colors.white),
                //             ),
                //           ],
                //         ))),
                SocialButton2(
                  width: _width,
                  title: "Connect with Github",
                  icon: FontAwesomeIcons.github,
                  color: Colors.blueGrey[600],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    String url = 'http://192.168.0.105:8000/login';
    var response = await http.post(url, body: {
      'email': _emailContoller.text,
      'password': _passwordContoller.text
    });
    if (response.statusCode == 202)
      print(json.decode(response.body));
    else {
      Flushbar(
        icon: Icon(Icons.error_outline, color: Colors.redAccent),
        leftBarIndicatorColor: Colors.redAccent,
        message: json.decode(response.body)['error_message'],
        duration: Duration(seconds: 3),
        isDismissible: true,
      )..show(context);
    }
  }
}

class LoginClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double roundnessFactor = 30.0;

    var path = Path();

    path.moveTo(size.width * 0.09, size.height * 0.0);

    path.lineTo(10, size.height - roundnessFactor);
    path.quadraticBezierTo(5, size.height, roundnessFactor, size.height);

    path.lineTo(size.width - roundnessFactor * 0.8, size.height * 0.83);
    path.quadraticBezierTo(
        size.width, size.height * 0.8, size.width, size.height * 0.6);

    path.lineTo(size.width, size.height * 0.45);
    path.quadraticBezierTo(size.width, size.height * 0.2,
        size.width - roundnessFactor * 0.7, size.height * 0.2);

    // path.quadraticBezierTo(0, size.height * 0.2, 0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
