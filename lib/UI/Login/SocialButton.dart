import 'package:codecards/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:codecards/Shared/Colors.dart';

class SocialButton extends StatelessWidget {
  final String title;
  final Icon icon;
  final Color color;
  final bool button;
  final bool loggedIn;

  SocialButton({this.title, this.icon, this.color, this.button, this.loggedIn});

  @override
  Widget build(BuildContext context) {
    return button
        ? Material(
            borderRadius: BorderRadius.circular(10),
            child: Ink(
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                onTap: () async {
                  switch (title) {
                    case 'Login With Facebook':
                      try {
                       await FacebookAuth().login().then((value) =>
                            Navigator.of(context).pushNamed('menuDashBoard'));
                      } catch (e) {
                        print(e.toString());
                      }
                      break;
                    case 'Login With Google':
                      try {
                       await GoogleAuth().handleSignIn().then((value) =>
                            Navigator.of(context).pushNamed('menuDashBoard'));
                      } catch (e) {
                        print(e.toString());
                      }
                      break;
                    case 'Login With Github':
                      print('Fucking Logged in with github');
                      //Navigator.of(context).pushNamed('menuDashBoard');
                      break;
                }
                },
                splashColor: White,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(left: 0, child: icon),
                      FractionallySizedBox(
                          child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          title,
                          style: TextStyle(color: White, fontSize: 17),
                        ),
                      )),
                      Positioned(
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: color,
            ),
            child: icon,
          );
  }
}
