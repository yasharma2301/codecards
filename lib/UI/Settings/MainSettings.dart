import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/UI/Settings/SettingsTile.dart';
import 'package:codecards/UI/Settings/UserInfo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainSettings extends StatefulWidget {
  @override
  _MainSettingsState createState() => _MainSettingsState();
}

class _MainSettingsState extends State<MainSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Grey,
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: ListView(
          children: [
            UserInfo(),
            SettingsTile(icon: Icons.book, title: "Bookmarks", onTap: (){print("=========================================");},),
            SettingsTile(icon: FontAwesomeIcons.palette, title: "Change Theme", onTap: () => print("Theme changed yay"),)
          ],
        ),
      ),
    );
  }
}
