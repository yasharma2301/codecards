import 'package:codecards/Services/AdProvider/adProvider.dart';
import 'package:codecards/Services/Themes/lightDarkThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/Shared/FlushBar.dart';
import 'package:codecards/Services/signupSignin/userRepository.dart';
import 'package:codecards/UI/Settings/Contact_US/Contact_US.dart';
import 'package:codecards/UI/Settings/RateUs/rateUs.dart';
import 'package:codecards/UI/Settings/UserInfo/UserInfo.dart';
import 'package:codecards/UI/Settings/settings2Tile.dart';
import 'AdMob/adTile.dart';
import 'Avatar/avatar.dart';
import 'Theme/AccentColorPicker.dart';
import 'Theme/themeSelector.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final UserRepository _userProvider = Provider.of<UserRepository>(context);
    HintCounter hintProvider = Provider.of<HintCounter>(context);
    final darkTheme = Provider.of<LightOrDarkTheme>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: darkTheme.getMode() == true ? Grey : Colors.white,
      body: Stack(
        children: [
          Container(
            color: darkTheme.getMode() == true ?LightGrey.withOpacity(0.15):Colors.white,
          ),
          Positioned(
            left: -(height / 2 - width / 2),
            top: -height * 0.2,
            child: Container(
              height: height,
              width: height,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: darkTheme.getMode() == true
                      ? LightGrey.withOpacity(0.4)
                      : Colors.grey.withOpacity(0.35)),
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
                color: darkTheme.getMode() == true
                    ? LightGrey.withOpacity(0.2)
                    : Colors.grey.withOpacity(0.1),
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
                color: darkTheme.getMode() == true
                    ? LightGrey.withOpacity(0.4)
                    : Colors.grey.withOpacity(0.2),
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
                      Text(
                        "Settings".toUpperCase(),
                        style: TextStyle(
                            color: darkTheme.getMode() == true ?White:LightGrey,
                            fontSize: 30,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat'),
                      ),
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
                                height: height / 5,
                                width: width / 2.5,
                                decoration: BoxDecoration(
                                    color:Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Colors.white70, width: 2)),
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                _userProvider.getUserAvatar()),
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
                                    color:  darkTheme.getMode() == true
                                        ? Grey:White,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Icon(
                                  Icons.edit,
                                  color:  darkTheme.getMode() == true
                                      ? White:Grey,
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
                UserInfo(
                  width: width,
                  settingsContext: context,
                ),
                ThemeSelector(),
                SizedBox(
                  height: 20,
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
                      onTap: () => _goToContactUs(context,_userProvider)),
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
                AdTile(
                  hintCounter: hintProvider,
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 50,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Material(
                elevation: 30,
                child: Container(
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(10)),
                    color: darkTheme.getMode() == true ?Grey:White,
                  ),
                  child: Icon(
                    Icons.keyboard_backspace,
                    color: darkTheme.getMode() == true ?Colors.white:Grey,
                  ),
                ),
              ),
            ),
          ),],
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
            child: AccentColorPicker(),
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

  void _goToContactUs(BuildContext context,UserRepository userRepository) async {
    dynamic instance = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ContactUs(userRepository: userRepository,)));
    FlushBar flushBar = FlushBar(context: context);

    if (instance != null) {
      flushBar.showSuccessFlushBar(
        instance['message'],
      );
    }
  }
}
