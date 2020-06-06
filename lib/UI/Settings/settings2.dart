import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/UI/Settings/ColorPicker.dart';
import 'package:codecards/UI/Settings/settings2Tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                            color: Grey),
                        child: Center(
                          child: FlareActor(
                            'assets/minion.flr',
                            alignment: Alignment.bottomCenter,
                            fit: BoxFit.cover,
                            animation: 'Stand',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                          color: Grey, borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, right: 15, left: 15),
                            child: TextFormField(
                              initialValue: "User69",
                              style: TextStyle(
                                color: Colors.blueAccent[100],
                                fontSize: 25
                              ),
                              cursorColor: Colors.orange,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Grey,
                                  size: 30,
                                ),
                                labelText: "Username",
                                labelStyle: TextStyle(
                                  color: Grey,
                                  fontSize: 20
                                ),
                                fillColor: LightGrey,
                                filled: true,
                                // enabledBorder: OutlineInputBorder(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(5)),
                                //   borderSide:
                                //       BorderSide(color: Colors.transparent),
                                // ),
                                // focusedBorder: OutlineInputBorder(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(5)),
                                //   borderSide:
                                //       BorderSide(color: Colors.transparent),
                                // ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: width,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                              gradient: LinearGradient(
                                  colors: [PopBlue, Colors.blueAccent[100]],
                                  stops: [0.1, 0.99],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.topRight,
                                  tileMode: TileMode.repeated),
                            ),
                            child: Center(
                              child: Text(
                                'SIGNED IN WITH GOOGLE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
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
                    onTap: _showColorPicker,
                  ),
                  Settings2Tile(
                    iconData: Icons.info,
                    title: 'MORE INFO',
                  ),
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
