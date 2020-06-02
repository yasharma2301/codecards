import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'MainSettings.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Grey,
      body: Stack(
        children: [
          Column(
            children: [
              // CustomAppBar(),
              Flexible(
                flex: 4,
                child: Container(
                  color: LightGrey.withOpacity(0.7),
                ),
              ),  
              Flexible(
                flex: 23,
                child: MainSettings(),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
            child: Align(
              alignment: Alignment.topCenter,
              // left: MediaQuery.of(context).size.width/2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      color: LightGrey,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: SvgPicture.asset("assets/coder.svg"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
