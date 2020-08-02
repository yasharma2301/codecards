import 'package:codecards/Services/Themes/accentColorProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/Shared/themesEnum.dart';

class SetAccent extends StatelessWidget {
  final double width;

  const SetAccent({Key key, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Container(
        width: width,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColorLight
              ],
              stops: [
                0.1,
                0.99
              ],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.topRight,
              tileMode: TileMode.repeated),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: 30,
              ),
              GestureDetector(
                onTap: () {
                  theme.setTheme(appThemeData[AppThemes.BluePop]);
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    gradient: LinearGradient(
                        colors: [PopBlue, Colors.blueAccent[100]],
                        stops: [0.1, 0.99],
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.topRight,
                        tileMode: TileMode.repeated),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              GestureDetector(
                onTap: () {
                  theme.setTheme(appThemeData[AppThemes.RipeMango]);
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    gradient: LinearGradient(
                        colors: [Colors.orange[400], Colors.amber[400]],
                        stops: [0.1, 0.99],
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.topRight,
                        tileMode: TileMode.repeated),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              GestureDetector(
                onTap: () {
                  theme.setTheme(appThemeData[AppThemes.MintGreen]);
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    gradient: LinearGradient(
                        colors: [Colors.green, Colors.lightGreen[500]],
                        stops: [0.1, 0.99],
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.topRight,
                        tileMode: TileMode.repeated),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              GestureDetector(
                onTap: () {
                  theme.setTheme(appThemeData[AppThemes.HotPink]);
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    gradient: LinearGradient(
                        colors: [
                          Colors.pinkAccent[100],
                          Colors.blueAccent[100]
                        ],
                        stops: [
                          0.1,
                          0.99
                        ],
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.topRight,
                        tileMode: TileMode.repeated),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              GestureDetector(
                onTap: () {
                  theme.setTheme(appThemeData[AppThemes.SeaGreen]);
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    gradient: LinearGradient(
                        colors: [Colors.greenAccent, SeaGreen],
                        stops: [0.1, 0.99],
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.topRight,
                        tileMode: TileMode.repeated),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
