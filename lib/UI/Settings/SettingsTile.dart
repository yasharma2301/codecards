import 'package:flutter/material.dart';
import 'package:codecards/Shared/Colors.dart';

class SettingsTile extends StatefulWidget {
  final IconData icon;
  final String title;
  String subtitle;
  final Function onTap;

  SettingsTile(
      {@required this.icon, @required this.title, this.onTap, this.subtitle});

  @override
  _SettingsTileState createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 60,
        width: 300,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: LightGrey),
        child: Container(
          // color: Blue,
          width: 350,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: Grey,
                size: 40,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(color: White, fontSize: 25),
                  ),
                  widget.subtitle != null
                      ? Text(
                          widget.subtitle,
                          style: TextStyle(fontSize: 20),
                        )
                      : Container()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
