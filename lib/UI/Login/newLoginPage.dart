import 'package:codecards/Services/signupSignin/userRepository.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/UI/Login/ForgotPassword.dart';
import 'package:codecards/UI/Login/newSignUp.dart';
import 'package:codecards/UI/Login/newSocialButton.dart';
import 'package:codecards/UI/MainNavigationUI/MenuDashboardLayout/menu_dashboard.dart';
import 'package:codecards/UI/OnBoard/onBoardNew.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flushbar/flushbar.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  double _height, _width;
  bool passwordVisible = true, passwordEmpty = true;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  bool _sheetCollapsed = true;

  @override
  Widget build(BuildContext context) {
    UserRepository _userProvider =
        Provider.of<UserRepository>(context, listen: false);

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
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AnimatedContainer(
                      height: _sheetCollapsed ? _height / 5 : _height / 2,
                      width: _width,
                      duration: Duration(microseconds: 200000),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/codecards.png"))),
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
                      height: _height / 45,
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
                      height: 10,
                    ),
                    Container(
                      width: _width,
                      child: GestureDetector(
                        onTap: () => _forgotPass(context),
                        child: Text(
                          'Forgot password?',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Colors.blueAccent[100].withOpacity(0.9),
                              fontSize: 17),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ClipPath(
                      clipper: LoginClipper(),
                      child: GestureDetector(
                        onTap: () =>
                            _userProvider.isLoading() ? {} : _login(context),
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
                          child: _userProvider.isLoading()
                              ? Center(
                                  child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              White)),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Login",
                                      style:
                                          TextStyle(color: White, fontSize: 20),
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
                    ),
                    Container(
                        width: _width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an Account? ",
                              style: TextStyle(fontSize: 16, color: White),
                            ),
                            GestureDetector(
                              onTap: () => _bringUpSignUp(context),
                              child: Text(
                                "Create one Now!",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.blueAccent[100]),
                              ),
                            )
                          ],
                        )),
                    Container(
                      height: _height / 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: White.withOpacity(0.4),
                            ),
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
                          Expanded(
                            child: Container(
                              height: 1,
                              color: White.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SocialButton2(
                      width: _width,
                      title: "Connect with Google",
                      icon: FontAwesomeIcons.google,
                      color: Color(0xFFF95A5F),
                      function: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MenuDashboardPage()));
                      },
                    ),
                    Divider(
                      color: Colors.transparent,
                      height: _height / 45,
                    ),
                    SocialButton2(
                      width: _width,
                      title: "Connect with Facebook",
                      icon: FontAwesomeIcons.facebook,
                      color: Colors.blueAccent[200],
                      function: () {},
                    ),
                    Divider(
                      color: Colors.transparent,
                      height: _height / 45,
                    ),
                    SocialButton2(
                      width: _width,
                      title: "Connect with Github",
                      icon: FontAwesomeIcons.github,
                      color: Colors.blueGrey[600],
                      function: () {
                        _bringUpSignUp(context);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    FocusScope.of(context).unfocus();

    if (_emailController.text.length > 5 &&
        _passwordController.text.length > 3) {
      UserRepository _userProvider =
          Provider.of<UserRepository>(context, listen: false);

      _userProvider
          .loginUser(_emailController.text, _passwordController.text)
          .then((value) {
        if (value) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MenuDashboardPage()),
              (route) => false);
        } else {
          Map response = _userProvider.getResponse();
          Flushbar(
            backgroundColor: Colors.blueGrey[900],
            icon: Icon(Icons.error_outline, color: Colors.redAccent),
            leftBarIndicatorColor: Colors.redAccent,
            message: response['responseMessage'],
            duration: Duration(seconds: 3),
            isDismissible: true,
          )..show(context).whenComplete(() {
              _userProvider.setLoading(false);
            });
        }
      });
    } else {
      Flushbar(
        icon: Icon(Icons.error_outline, color: Colors.redAccent),
        leftBarIndicatorColor: Colors.redAccent,
        message: "Please provide a valid email and password!",
        duration: Duration(seconds: 3),
        isDismissible: true,
      )..show(context);
    }
  }

  void _bringUpSignUp(BuildContext context) {
    setState(() {
      _sheetCollapsed = false;
    });
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25))),
              child: newSignUp());
        }).whenComplete(() {
      setState(() {
        _sheetCollapsed = true;
      });
    });
  }

  void _forgotPass(context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Grey,
            child: ForgotPassword(),
          );
        });
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

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
