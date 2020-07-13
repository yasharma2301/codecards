import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:codecards/Services/signupSignin/userRepository.dart';

class newSignUp extends StatefulWidget {
  @override
  _newSignUpState createState() => _newSignUpState();
}

class _newSignUpState extends State<newSignUp> {
  bool passwordVisible = true, passwordEmpty = true;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    UserRepository _userProvider = Provider.of<UserRepository>(context);

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
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
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
                  controller: _usernameController,
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
                  controller: _passwordController,
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
                  controller: _password2Controller,
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
                  if (!_userProvider.isLoading())
                    _signUp(context, _userProvider);
                },
                child: ClipPath(
                  clipper: SignUpClipper(),
                  child: Container(
                    width: _width / 1.7,
                    height: _height / 12,
                    color: Color(0xFFF95A5F).withOpacity(0.8),
                    child: _userProvider.isLoading()
                        ? Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(White),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sign Up",
                                style: TextStyle(color: White, fontSize: 20),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.arrow_forward, color: White),
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

  Future<void> _signUp(BuildContext context, _userProvider) async {
    FocusScope.of(context).unfocus();

    _userProvider.registerUser(_emailController.text, _usernameController.text,
        _passwordController.text, _password2Controller.text);

    Map response = _userProvider.getResponse();

    if (response['responseCode'] == 201) {
      print(response['responseMessage']);
      Navigator.pop(context);
    } else {
      Flushbar(
        icon: Icon(Icons.error_outline, color: Colors.redAccent),
        leftBarIndicatorColor: Colors.redAccent,
        message: response['responseMessage'],
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
