import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/Shared/themes.dart';
import 'package:codecards/UI/Settings/Avatar/avatar_provider.dart';
import 'package:codecards/UI/Settings/Contact_US/Contact_US.dart';
import 'package:codecards/UI/Settings/RateUs/rateUs.dart';
import 'package:codecards/UI/Settings/UserInfo.dart';
import 'package:codecards/UI/Settings/settings2Tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';
import 'Avatar/avatar.dart';
import 'Theme/ColorPicker.dart';
import 'adTile.dart';
import 'themeSelector.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String currentTheme = "dark";

  @override
  Widget build(BuildContext context) {
    final AvatarChanger avatarChanger = Provider.of<AvatarChanger>(context);

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
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 50, right: 20, left: 22.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Settings",
                          style: TextStyle(
                              color: White,
                              fontSize: 40,
                              fontWeight: FontWeight.w500)),
                      GestureDetector(
                        onTap: () async {
                          if (await Vibration.hasVibrator()) {
                            Vibration.vibrate(duration: 5);
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Avatar(),
                          ));
                        },
                        child: Stack(
                          children: [
                            Hero(
                              tag: 'avatarHero',
                              child: Container(
                                height: 170,
                                width: 170,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Colors.white70, width: 2)),
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                avatarChanger.getAvatar()),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Grey,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Icon(
                                  Icons.edit,
                                  color: White,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // SetUsername(width:width,height: height,),
                UserInfo(width: width),
                ThemeSelector(),
                SizedBox(
                  height: 20,
                ),
                Settings2Tile(
                  iconData: currentTheme == "dark"
                      ? Icons.brightness_4
                      : Icons.brightness_7,
                  title: currentTheme == "dark" ? "DARK THEME" : "LIGHT THEME",
                  onTap: () {
                    if (currentTheme == "dark") {
                      setState(() {
                        currentTheme = "light";
                      });
                    } else {
                      setState(() {
                        currentTheme = "dark";
                      });
                    }
                  },
                ),
                Settings2Tile(
                  onTap: _showTimePicker,
                  iconData: Icons.timer,
                  title: 'CHANGE DAILY\nREMINDER TIME',
                ),
                Settings2Tile(
                    iconData: FontAwesomeIcons.fill,
                    title: "CHANGE\nACCENT COLOR",
                    onTap: _showColorPicker),
                Hero(
                  tag: 'contactUsPage',
                  child: Settings2Tile(
                      iconData: Icons.call,
                      title: 'SUPPORT',
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ContactUs()))),
                ),
                Settings2Tile(
                  iconData: Icons.star,
                  title: "RATE US",
                  onTap: _showRatingModal,
                ),
                Settings2Tile(
                  iconData: Icons.info,
                  title: 'MORE INFO',
                ),
                SizedBox(
                  height: 10,
                ),
                AdTile(),
              ],
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
                  // color: Colors.white,
                  color: Theme.of(context).primaryColor,
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
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Grey,
            child: ColorPicker(),
          );
        });
  }

  void _showRatingModal() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Grey,
            child: RateUs(),
          );
        });
  }
}
