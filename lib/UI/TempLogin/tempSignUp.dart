import 'package:codecards/Services/signupSignin/userRepository.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignUpTemp extends StatefulWidget {
  @override
  _SignUpTempState createState() => _SignUpTempState();
}

class _SignUpTempState extends State<SignUpTemp> {
  String _email, _password, _confirmPassword, _username;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Black,
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
                  color: LightGrey.withOpacity(0.26),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  _buildLoginForm(),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: MaterialButton(
                      padding: EdgeInsets.all(17),
                      color: Colors.blueAccent[100],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Align(
                          child:
                              Provider.of<UserRepository>(context).isLoading()
                                  ? CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                      strokeWidth: 2,
                                    )
                                  : Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    )),
                      onPressed: () async {
                        await Provider.of<UserRepository>(context,
                                listen: false)
                            .registerUser(
                                _email, _username, _password, _confirmPassword)
                            .then((value) {
                          Navigator.popAndPushNamed(context, 'menuDashBoard');
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 0.5,
                        width: MediaQuery.of(context).size.width / 3,
                        color: White,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "OR",
                        style: TextStyle(color: White, fontSize: 18),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 0.5,
                        width: MediaQuery.of(context).size.width / 3,
                        color: White,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Navigator.pushNamed(context, 'loginTemp');
                    },
                    child: Text(
                      "Already have an account?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blueAccent[100],
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
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
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  color: Theme.of(context).primaryColor),
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
                            FontAwesomeIcons.users,
                            size: 18,
                            color: Grey,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _username = value;
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
                              FontAwesomeIcons.key,
                              size: 18,
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
                              FontAwesomeIcons.key,
                              size: 18,
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
                  SizedBox(height: 20)
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
                      color: Theme.of(context).primaryColor, width: 3)),
              child: CircleAvatar(
                radius: 45.0,
                backgroundColor: Grey,
                child: Image.network(
                  "https://img.icons8.com/bubbles/344/enter-2.png",
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
