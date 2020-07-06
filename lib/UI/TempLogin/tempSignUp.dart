import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpTemp extends StatefulWidget {
  static final String path = "lib/src/pages/login/signup1.dart";

  @override
  _SignUpTempState createState() => _SignUpTempState();
}

class _SignUpTempState extends State<SignUpTemp> {
  String _email, _password, _confirmPassword, _username;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Grey,
        body: Stack(
          children: [
            Container(
              color: LightGrey.withOpacity(0.15),
            ),
            Positioned(
              left: -(MediaQuery.of(context).size.height / 2 -
                  MediaQuery.of(context).size.width / 2),
              top: -MediaQuery.of(context).size.height * 0.2,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: LightGrey.withOpacity(0.4)),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.15,
              top: -MediaQuery.of(context).size.width * 0.5,
              child: Container(
                height: MediaQuery.of(context).size.width * 1.6,
                width: MediaQuery.of(context).size.width * 1.6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: LightGrey.withOpacity(0.2),
                ),
              ),
            ),
            Positioned(
              right: -MediaQuery.of(context).size.width * 0.2,
              top: -50,
              child: Container(
                height: MediaQuery.of(context).size.width * 0.6,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: LightGrey.withOpacity(0.4),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // SizedBox(
                  //   height: 30.0,
                  // ),
                  CircleAvatar(
                    child: Image.network(
                        "https://img.icons8.com/bubbles/344/enter-2.png"),
                    maxRadius: 50,
                    backgroundColor: Colors.transparent,
                  ),
                  // SizedBox(
                  //   height: 20.0,
                  // ),
                  _buildLoginForm(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Material(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        splashColor: Theme.of(context).primaryColorLight,
                        onTap: _signUp,
                        child: Ink(
                          decoration: BoxDecoration(
                              color: Grey,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Theme.of(context).primaryColorLight)),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text("Sign Up",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: White, fontSize: 20)),
                        ),
                        // color: Grey,
                      ),
                    ),
                  ),
                  // SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 2,
                        width: MediaQuery.of(context).size.width / 2.5,
                        color: White,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "OR",
                        style: TextStyle(color: White, fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 2,
                        width: MediaQuery.of(context).size.width / 2.5,
                        color: White,
                      ),
                    ],
                  ),
                  // SizedBox(height: 15),
                  GestureDetector(
                    onTap: () async {
                      dynamic instance =
                          await Navigator.pushNamed(context, 'loginTemp');
                      if (instance['success']) {
                        Navigator.popAndPushNamed(context, 'menuDashBoard');
                      }
                    },
                    child: Text("Already have an account?",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Blue, fontSize: 22)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildLoginForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: RoundedDiagonalPathClipper(),
            child: Container(
              // height: 400,
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 90.0,
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Theme.of(context).primaryColorLight,
                        style: TextStyle(color: Grey),
                        decoration: InputDecoration(
                            hintText: "Email address",
                            hintStyle: TextStyle(color: Grey),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.email,
                              color: Grey,
                            )),
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                      )),
                  Container(
                    child: Divider(
                      height: 15,
                      color: Grey,
                    ),
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        cursorColor: Theme.of(context).primaryColorLight,
                        style: TextStyle(color: Grey),
                        decoration: InputDecoration(
                            hintText: "Username",
                            hintStyle: TextStyle(color: Grey),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.email,
                              color: Grey,
                            )),
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                      )),
                  Container(
                    child: Divider(
                      height: 15,
                      color: Grey,
                    ),
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        cursorColor: Theme.of(context).primaryColorLight,
                        style: TextStyle(color: Grey),
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: Grey),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              color: Grey,
                            )),
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                      )),
                  Container(
                    child: Divider(
                      height: 15,
                      color: Grey,
                    ),
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        cursorColor: Theme.of(context).primaryColorLight,
                        style: TextStyle(color: Grey),
                        decoration: InputDecoration(
                            hintText: "Confirm Password",
                            hintStyle: TextStyle(color: Grey),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              color: Grey,
                            )),
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            _confirmPassword = value;
                          });
                        },
                      )),
                  Container(
                    child: Divider(
                      height: 15,
                      color: Grey,
                    ),
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0),
                  ),
                  SizedBox(height: 10)
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                      color: Theme.of(context).primaryColorLight, width: 2)),
              child: CircleAvatar(
                radius: 40.0,
                backgroundColor: Grey,
                child: Icon(Icons.person),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signUp() async {
    String url = 'http://192.168.0.104:8000/register';
    Map user = {
      'email': _email,
      'username': _username,
      'password': _password,
      'password2': _confirmPassword
    };
    bool _confirm = true;
    user.forEach((key, value) {
      if (value == null || value == "") {
        _confirm = false;
      }
    });

    user.addAll({'avatar': ""});

    if (_confirm) {
      var response = await http.post(url, body: user);
      print('Response status: ${response.statusCode}');
      print("Response Body: ${response.body}");
      response.statusCode == 201
          ? Navigator.popAndPushNamed(context, 'menuDashBoard')
          : ("Response Error: ${response.body}");
    }
  }
}

class RoundedDiagonalPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(0, size.height * 0.2);

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
