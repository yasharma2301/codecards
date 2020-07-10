import 'package:flutter/material.dart';

class SocialButton2 extends StatefulWidget {
  final double width;
  final String title;
  final IconData icon;
  final Color color;

  SocialButton2({Key key, this.width, this.title, this.icon, this.color})
      : super(key: key);

  @override
  _SocialButton2State createState() => _SocialButton2State();
}

class _SocialButton2State extends State<SocialButton2> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      splashColor: widget.color,
      onTap: () {},
      child: Ink(
          width: widget.width,
          height: 55,
          decoration: BoxDecoration(
              // color: widget.color,
              border: Border.all(color: widget.color, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  widget.icon,
                  color: Colors.white,
                ),
                SizedBox(
                  width: widget.width / 4,
                ),
                Text(
                  widget.title,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          )),
    );
  }
}
