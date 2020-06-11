import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/UI/Settings/UserInfo.dart';
import 'package:codecards/UI/Settings/setTheme.dart';
import 'package:codecards/UI/Settings/settings2Tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ColorPicker.dart';
import 'adTile.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Grey,
      body: Stack(
        children: [
          Container(
            color: LightGrey.withOpacity(0.15),
          ),
          Positioned(
            left: -(height / 2 - width / 2),
            top: -height * 0.2,
            child: Container(
              height: height,
              width: height,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: LightGrey.withOpacity(0.4)),
            ),
          ),
          Positioned(
            left: width * 0.15,
            top: -width * 0.5,
            child: Container(
              height: width * 1.6,
              width: width * 1.6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: LightGrey.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            right: -width * 0.2,
            top: -50,
            child: Container(
              height: width * 0.6,
              width: width * 0.6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: LightGrey.withOpacity(0.4),
              ),
            ),
          ),
          Container(
            width: width,
            height: height,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 200, right: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 170,
                        width: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Grey,
                        ),
                        child: Center(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // SetUsername(width:width,height: height,),
                  UserInfo(width: width),
                  Settings2Tile(
                    iconData: Icons.bookmark,
                    title: 'BOOKMARKS',
                  ),
                  Settings2Tile(
                    onTap: _showTimePicker,
                    iconData: Icons.timer,
                    title: 'CHANGE DAILY\nREMINDER TIME',
                  ),
                  Settings2Tile(
                    iconData: Icons.call,
                    title: 'CONTACT US',
                  ),
                  Settings2Tile(
                    iconData: FontAwesomeIcons.fill,
                    title: "Change Accent Color",
                    onTap: _showColorPicker
                  ),
                  Settings2Tile(
                    iconData: Icons.info,
                    title: 'MORE INFO',
                  ),
                  // SetTheme(width:width),
                  AdTile(),
                ],
              ),
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
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TimeOfDay time = TimeOfDay(hour: 19, minute: 0);

  Future<void> _showTimePicker() async {
    final TimeOfDay pickedTime =
        await showTimePicker(context: context, initialTime: time);
    if (pickedTime != null && pickedTime != time) {
      setState(() {
        time = pickedTime;
      });
    }
  }

  // Color Picker

  Color accentColor = PopBlue;

  Future<void> _showColorPicker() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog (
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          backgroundColor: Grey,
          child: ColorPicker(),
        );
      }
    );
  }
}
