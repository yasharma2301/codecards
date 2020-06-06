import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';

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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
      child: Container(
        height: 80,
        width: width,
        decoration:
            BoxDecoration(color: Grey, borderRadius: BorderRadius.circular(8)),
        child: Stack(fit: StackFit.expand, children: [
          Positioned(
            right: 0,
            top: 0,
            child: Container(
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
                    fontSize: 17,
                  ),
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
                  child: Icon(
                    iconData,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ]),
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
