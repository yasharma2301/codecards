import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';
import 'dart:convert';

class newSignUp extends StatefulWidget {
  @override
  _newSignUpState createState() => _newSignUpState();
}

class _newSignUpState extends State<newSignUp> {
  bool passwordVisible = true, passwordEmpty = true;
  TextEditingController _passwordContoller = TextEditingController();
  TextEditingController _password2Contoller = TextEditingController();
  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _usernameContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Grey,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Create a new Account',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
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
                        Icons.mail_outline,
                        color: Grey,
                      ),
                      border: InputBorder.none,
                      hintText: "Enter Email",
                      hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.6), fontSize: 16)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: LightGrey.withOpacity(0.7),
                ),
                child: TextFormField(
                  controller: _usernameContoller,
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
                      hintText: "Enter Username",
                      hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.6), fontSize: 16)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
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
                        Icons.vpn_key,
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
                          color: Colors.white.withOpacity(0.6), fontSize: 16)),
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
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: LightGrey.withOpacity(0.7),
                ),
                child: TextFormField(
                  controller: _password2Contoller,
                  obscureText: true,
                  style: TextStyle(
                    color: White.withOpacity(0.7),
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.vpn_key,
                        color: Grey,
                      ),
                      border: InputBorder.none,
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.6), fontSize: 16)),
                ),
              ),
              SizedBox(
                height: _height / 45,
              ),
              InkWell(
                onTap: () {
                  _signUp(context);
                },
                child: ClipPath(
                  clipper: SignUpClipper(),
                  child: Container(
                    width: _width / 1.7,
                    height: _height / 12,
                    color: Color(0xFFF95A5F).withOpacity(0.8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sign Up",
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
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signUp(BuildContext context) async {
    FocusScope.of(context).unfocus();

    String url = 'http://192.168.0.105:8000/register';

    var response = await http.post(url, body: {
      'email': _emailContoller.text,
      'username': _usernameContoller.text,
      'password': _passwordContoller.text,
      'password2': _password2Contoller.text,
      'avatar': ''
    });

    if (response.statusCode == 201) {
      print(response.body);
      Navigator.pop(context);
    } else {
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

class SignUpClipper extends CustomClipper<Path> {
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

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
