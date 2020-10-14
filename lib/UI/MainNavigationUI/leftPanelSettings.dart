import 'package:codecards/Services/AdProvider/adProvider.dart';
import 'package:codecards/Services/Themes/lightDarkThemeProvider.dart';
import 'package:codecards/Services/signupSignin/userRepository.dart';
import 'package:codecards/Shared/FlushBar.dart';
import 'package:codecards/UI/Settings/AdMob/adTile.dart';
import 'package:codecards/UI/Settings/Avatar/avatar.dart';
import 'package:codecards/UI/Settings/Contact_US/Contact_US.dart';
import 'package:codecards/UI/Settings/RateUs/rateUs.dart';
import 'package:codecards/UI/Settings/Theme/AccentColorPicker.dart';
import 'package:codecards/UI/Settings/Theme/themeSelector.dart';
import 'package:codecards/UI/Settings/UserInfo/UserInfo.dart';
import 'package:codecards/UI/Settings/settings2Tile.dart';
import 'package:flutter/material.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';
import 'Bloc/navigation_bloc.dart';
import 'MenuDashboardLayout/menu_dashboard.dart';


class LeftPanelSettings extends StatelessWidget with NavigationStates {
  final Function onMenuTap;
  LeftPanelSettings({Key key, this.onMenuTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserRepository _userProvider = Provider.of<UserRepository>(context);
    HintCounter hintProvider = Provider.of<HintCounter>(context);
    final darkTheme = Provider.of<LightOrDarkTheme>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        return Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MenuDashboardPage()));
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          double currentWidth = constraints.constrainWidth();
          double maxWidth = MediaQuery.of(context).size.width;
          bool border;
          if (maxWidth == currentWidth) {
            border = false;
          } else {
            border = true;
          }
          return Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: PopBlue.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 1)
                ],
                borderRadius: border
                    ? BorderRadius.circular(30)
                    : BorderRadius.circular(0),
                color: darkTheme.getMode() == true ?Grey:White),
            child: ClipRRect(
              borderRadius:
              border ? BorderRadius.circular(30) : BorderRadius.circular(0),
              child: Stack(
                children: [
                  Positioned(
                    left: -(height / 2 - width / 2),
                    top: -height * 0.13,
                    child: Container(
                      height: height,
                      width: height,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: darkTheme.getMode() == true
                              ? LightGrey.withOpacity(0.15)
                              : Colors.grey.withOpacity(0.3)),
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
                            ? LightGrey.withOpacity(0.1)
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
                            ? LightGrey.withOpacity(0.1)
                            : Colors.grey.withOpacity(0.1),
                      ),
                    ),
                  ),
                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: 50,),
                          Padding(
                            padding:
                            const EdgeInsets.only(right: 20, left: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
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
                                          width: border==true?maxWidth/5:width / 2.5,
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
                            //onTap: _showTimePicker,
                            iconData: Icons.timer,
                            title: 'CHANGE DAILY\nREMINDER TIME',
                          ),
                          Settings2Tile(
                              iconData: FontAwesomeIcons.fill,
                              title: "CHANGE\nACCENT COLOR",
                              onTap: (){_showColorPicker(context);}),
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
                            onTap: (){_showRatingModal(context);},
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
                  ),
                  Positioned(
                    left: 0,
                    top: 40,
                    child: GestureDetector(
                      onTap: onMenuTap,
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
                            Icons.menu,
                            color: darkTheme.getMode() == true ?Colors.white:Grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Color Picker

  Color accentColor = PopBlue;

  Future<void> _showColorPicker(BuildContext context) async {
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

  void _showRatingModal(BuildContext context) {
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
