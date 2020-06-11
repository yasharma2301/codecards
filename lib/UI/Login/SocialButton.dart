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
                onTap: () {
                  Navigator.of(context).pushNamed('menuDashBoard');
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
