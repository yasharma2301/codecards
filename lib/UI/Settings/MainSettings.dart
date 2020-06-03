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
  // Time Picker
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Grey,
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: ListView(
          children: [
            UserInfo(),
            SettingsTile(
              icon: Icons.book,
              title: "Bookmarks",
              onTap: () {
                print("=========================================");
              },
            ),
            SettingsTile(
              icon: FontAwesomeIcons.palette,
              title: "Change Theme",
              onTap: () => print("Theme changed yay"),
            ),
            SettingsTile(
              icon: Icons.access_time,
              title: time.format(context),
              subtitle: "Change daily reminder time",
              onTap: _showTimePicker 
            )
          ],
        ),
      ),
    );
  }
}
