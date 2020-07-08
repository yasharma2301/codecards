import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/UI/TempLogin/Reset_Password_Webview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class LoginTemp extends StatefulWidget {
  static final String path = "lib/src/pages/login/Login1.dart";

  @override
  _LoginTempState createState() => _LoginTempState();
}

class _LoginTempState extends State<LoginTemp> {
  String _email, _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CircleAvatar(
                  child: Image.network(
                      "https://img.icons8.com/bubbles/344/enter-2.png"),
                  maxRadius: 70,
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  height: 20.0,
                ),
                _buildLoginForm(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),
                  child: Material(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      splashColor: Theme.of(context).primaryColorLight,
                      onTap: _login,
                      child: Ink(
                        decoration: BoxDecoration(
                            color: Grey,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Theme.of(context).primaryColorLight)),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text("Log In",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: White, fontSize: 20)),
                      ),
                      // color: Grey,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20),
                    child: GestureDetector(
                      onTap: _resetPassword,
                      child: Text(
                        "Forgot Password?",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Blue,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                    ))
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 50,
            child: Container(
              height: 40,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(10)),
                color: Grey,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.keyboard_backspace,
                  // color: Colors.white,
                  color: White,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildLoginForm() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: RoundedDiagonalPathClipper(),
            child: Container(
              padding: EdgeInsets.all(10.0),
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
                      color: Grey,
                    ),
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
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
                      color: Grey,
                    ),
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
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
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _login() async {
    String url = 'http://192.168.0.105:8000/login';
    Map user = {
      'email': _email,
      'password': _password,
    };
    bool _confirm = true;
    user.forEach((key, value) {
      if (value == null || value == "") {
        _confirm = false;
      }
    });

    if (_confirm) {
      var response = await http.post(url, body: user);
      print('Response status: ${response.statusCode}');
      print("Response Body: ${response.body}");
      response.statusCode == 202
          ? Navigator.pop(context, {'success': true})
          : ("Response Error: ${response.body}");
    }
  }

  Future<void> _resetPassword() async {
    // const url = 'http://192.168.0.105:8000/reset_password/';
    // if (await canLaunch(url)) {
    //   await launch(
    //     url,
    //   );
    // } else {
    //   throw 'Could not launch $url';
    // }
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ResetPassword()));
  }
}

class RoundedDiagonalPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(0, size.height * 0.3);

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
