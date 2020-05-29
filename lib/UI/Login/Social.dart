import 'package:flutter/material.dart';
import 'SocialButton.dart';

class Social extends StatefulWidget {
  bool opened;
  Animation moveSocial;
  String title;
  Color color;
  Icon icon;
  double position;

  Social(
      {@required this.opened,
      @required this.moveSocial,
      @required this.color,
      @required this.icon,
      @required this.title,
      @required this.position});

  @override
  _SocialState createState() => _SocialState();
}

class _SocialState extends State<Social> {
  @override
  Widget build(BuildContext context) {
    return Transform(
        transform: Matrix4.translationValues(
            0, widget.position * widget.moveSocial.value, 0),
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          height: 50,
          width: widget.opened ? 300 : 50,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          curve: Curves.bounceOut,
          child: SocialButton(
              button: widget.opened,
              title: widget.title,
              color: widget.color,
              icon: widget.icon),
        ));
  }
}
