import 'package:codecards/Shared/delayed_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/Shared/FlushBar.dart';
import 'package:codecards/Services/signupSignin/userRepository.dart';
import 'package:codecards/UI/MainNavigationUI/MenuDashboardLayout/menu_dashboard.dart';

class NewSignUp extends StatefulWidget {
  @override
  _NewSignUpState createState() => _NewSignUpState();
}

class _NewSignUpState extends State<NewSignUp> {
  bool passwordVisible = true, passwordEmpty = true;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Grey,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white24,
                        offset: Offset(0, 0),
                        blurRadius: 10,
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColorLight
                        ],
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.topRight,
                        tileMode: TileMode.repeated),
                  ),
                  child: Center(
                    child: Text(
                      'Create New Account',
                      style: TextStyle(
                          color: Grey.withOpacity(0.9),
                          fontSize: 24,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      DelayedAnimation(
                        delay: 20,
                        child: Column(
                          children: [
                            Container(
                              padding:
                              EdgeInsets.symmetric(horizontal: 18, vertical: 5),
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
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 16)),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding:
                              EdgeInsets.symmetric(horizontal: 18, vertical: 5),
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
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 16)),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding:
                              EdgeInsets.symmetric(horizontal: 18, vertical: 5),
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
                              height: 15,
                            ),
                            Container(
                              padding:
                              EdgeInsets.symmetric(horizontal: 18, vertical: 5),
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
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 16)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      DelayedAnimation(
                        delay: 110,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _signUp(context);
                              },
                              child: ClipPath(
                                clipper: SignUpClipper(),
                                child: Container(
                                  width: _width / 1.7,
                                  height: _height / 12,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Theme.of(context).primaryColor,
                                          Theme.of(context).primaryColorLight
                                        ],
                                        begin: FractionalOffset.topLeft,
                                        end: FractionalOffset.topRight,
                                        tileMode: TileMode.repeated),
                                  ),
                                  child: Provider.of<UserRepository>(context)
                                      .isLoading()
                                      ? Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                      valueColor:
                                      AlwaysStoppedAnimation<Color>(White),
                                    ),
                                  )
                                      : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Sign Up",
                                        style: TextStyle(
                                            color: White, fontSize: 20),
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
                            ),
                            Column(
                              children: [
                                Text(
                                  'By signing in you agree to the all the',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    'Terms and Conditions',
                                    style: TextStyle(
                                        color:
                                        Colors.blueAccent[100].withOpacity(0.8),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signUp(BuildContext context) async {
    UserRepository _userProvider =
        Provider.of<UserRepository>(context, listen: false);

    FocusScope.of(context).unfocus();
    FlushBar flushBar = FlushBar(context: context);

    _userProvider
        .registerUser(_emailController.text, _usernameController.text,
            _passwordController.text, _password2Controller.text)
        .then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MenuDashboardPage()),
            (route) => false);
      } else {
        Map response = _userProvider.getResponse();
        flushBar
            .showErrorFlushBar(
          response['responseMessage'],
        )
            .whenComplete(() {
          _userProvider.setLoading(false);
        });
      }
    });
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
