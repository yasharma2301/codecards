import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:codecards/Shared/Colors.dart';

class Settings2Tile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function onTap;

  const Settings2Tile({
    Key key,
    this.iconData,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Material(
            child: InkWell(
              highlightColor: Grey,
              splashColor: Grey,
              borderRadius: BorderRadius.circular(8),
              onTap: onTap,
              child: Ink(
                height: 80,
                width: width,
                decoration: BoxDecoration(
                    color: Grey, borderRadius: BorderRadius.circular(8)),
                child: Stack(fit: StackFit.expand, children: [
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColorLight
                              ],
                              stops: [
                                0.3,
                                0.95
                              ],
                              begin: FractionalOffset.topLeft,
                              end: FractionalOffset.topRight,
                              tileMode: TileMode.repeated),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(50),
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8))),
                      height: 80,
                      width: width - 110,
                      child: Center(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Positioned(
                        left: 20,
                        top: 25,
                        child: RadiantGradientMask(
                          child: FaIcon(
                            iconData,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.bottomCenter,
        radius: 0.999,
        colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).primaryColorLight
        ],
        tileMode: TileMode.clamp,
      ).createShader(bounds),
      child: child,
    );
  }
}
