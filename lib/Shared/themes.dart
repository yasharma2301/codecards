import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';

enum AppThemes { BluePop, RipeMango, MintGreen, HotPink, SeaGreen }

final appThemeData = {
  AppThemes.BluePop: ThemeData(
    primaryColorLight: Colors.blueAccent[100],
    primaryColor: PopBlue,
    primarySwatch: Colors.blueGrey,
  ),
  AppThemes.MintGreen: ThemeData(
    primaryColorLight: Colors.lightGreen[500],
    primaryColor: Colors.green,
    primarySwatch: Colors.blueGrey,
  ),
  AppThemes.RipeMango: ThemeData(
    primaryColorLight: Colors.amber[300],
    primaryColor: Colors.orange[400],
    primarySwatch: Colors.blueGrey,
  ),
  AppThemes.HotPink: ThemeData(
    primaryColorLight: Colors.blueAccent[100],
    primaryColor: Colors.pinkAccent[100],
    primarySwatch: Colors.blueGrey,
  ),
  AppThemes.SeaGreen: ThemeData(
    primaryColorLight: SeaGreen,
    primaryColor: Colors.greenAccent,
    primarySwatch: Colors.blueGrey,
  ),
};

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;

  ThemeChanger(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}
