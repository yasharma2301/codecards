import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';

class MainSettings extends StatefulWidget {
  @override
  _MainSettingsState createState() => _MainSettingsState();
}

class _MainSettingsState extends State<MainSettings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 200,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: LightGrey),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Grey
                  ),
                  child: TextFormField(
                    initialValue: "Coder69",
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 30
                    ),
                    cursorColor: Colors.orange,
                    decoration: InputDecoration(
                      labelText: "USERNAME",
                      labelStyle: TextStyle(
                        color: White,
                        fontSize: 20
                      ),
                      border: InputBorder.none
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue[300]
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 50,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: LightGrey),
            child: Text(
              "Hellow",
              style: TextStyle(color: White),
            ),
          ),
        ],
      ),
    );
  }
}
