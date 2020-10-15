import 'package:codecards/Shared/delayed_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:codecards/Services/signupSignin/userRepository.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/Shared/FlushBar.dart';
import 'package:codecards/UI/OnBoard/Login/ForgotPassword.dart';
import 'package:codecards/UI/OnBoard/Login/newSignUp.dart';
import 'package:codecards/UI/MainNavigationUI/MenuDashboardLayout/menu_dashboard.dart';
import 'package:codecards/UI/OnBoard/onBoardNew.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  double _height, _width;
  bool passwordVisible = true, passwordEmpty = true;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  double _scale;
  AnimationController _controller;
  bool _keyboardState;

  @override
  void initState() {
    _keyboardState = KeyboardVisibility.isVisible;
    KeyboardVisibility.onChange.listen((bool visible) {
      setState(() {
        _keyboardState = visible;
      });
    });
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _sheetCollapsed = true;

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    var height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    var width = MediaQuery.of(context).size.width;
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
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            Container(
              height: height * 0.9,
              width: width,
              decoration: BoxDecoration(
                color: Grey,
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MenuDashboardPage()));
                          },
                          child: AnimatedContainer(
                            height: _sheetCollapsed ? _height / 4 : _height,
                            width: _width,
                            duration: Duration(microseconds: 200000),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/codecards.png"))),
                          ),
                        ),
                        DelayedAnimation(
                          delay: 100,
                          child: Text(
                            'Namaste!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                                color: Colors.white,
                                fontFamily: 'Montserrat'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DelayedAnimation(
                          delay: 150,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 5),
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 5),
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
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blueAccent[100],
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Don't have an Account?",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: White,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _bringUpSignUp(context),
                                child: Text(
                                  "Create one Now!",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blueAccent[100]),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: height * 0.85,
              left: width * 0.1,
              child: GestureDetector(
                onTap: () => _userProvider.isLoading() ? {} : _login(context),
                onTapDown: _onTapDown,
                onTapUp: _onTapUp,
                child: Transform.scale(
                  scale: _scale,
                  child: Container(
                    height: 60,
                    width: width - width * 0.2,
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Grey.withOpacity(0.5),
                            blurRadius: 10.0,
                            offset: Offset(0.0, 5))
                      ],
                      borderRadius: BorderRadius.circular(50),
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
                                    new AlwaysStoppedAnimation<Color>(White)),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.arrow_forward, color: White)
                            ],
                          ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Opacity(
                  opacity: _keyboardState ?0:1,
                  child: Text(
                    'By signing in you agree to all the\nterms and conditions.',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  Future<void> _login(BuildContext context) async {
    FocusScope.of(context).unfocus();
    FlushBar flushBar = FlushBar(context: context);

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
          flushBar.showErrorFlushBar(response['responseMessage']);
          _userProvider.setLoading(false);
          print(_userProvider.isLoading());
        }
      });
    } else {
      flushBar.showErrorFlushBar("Please provide a valid email and password!");
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
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25))),
              child: NewSignUp());
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
