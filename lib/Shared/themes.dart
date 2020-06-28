import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';

enum AppThemes {
  BluePop,
  RipeMango,
  MintGreen,
  HotPink,
  SeaGreen,
  Violet,
  SunRise,
  NewLeaf,
  MetalGreen,
  GreenApple
}

final appThemeData = {
  AppThemes.BluePop: ThemeData(
    primaryColorLight: Colors.blueAccent[100],
    primaryColor: PopBlue,
    primarySwatch: Colors.blueGrey,
    canvasColor: Colors.transparent,
  ),
  AppThemes.MintGreen: ThemeData(
      primaryColorLight: Colors.lightGreen[500],
      primaryColor: Colors.green,
      primarySwatch: Colors.blueGrey,
      canvasColor: Colors.transparent),
  AppThemes.RipeMango: ThemeData(
      primaryColorLight: Colors.amber[300],
      primaryColor: Colors.orange[400],
      primarySwatch: Colors.blueGrey,
      canvasColor: Colors.transparent),
  AppThemes.HotPink: ThemeData(
      primaryColorLight: Colors.blueAccent[100],
      primaryColor: Colors.pinkAccent[100],
      primarySwatch: Colors.blueGrey,
      canvasColor: Colors.transparent),
  AppThemes.SeaGreen: ThemeData(
      primaryColorLight: SeaGreen,
      primaryColor: Colors.greenAccent,
      primarySwatch: Colors.blueGrey,
      canvasColor: Colors.transparent),
  AppThemes.Violet: ThemeData(
      primaryColorLight: Color(0xFFeaafc8),
      primaryColor: Color(0xFF654ea3),
      primarySwatch: Colors.blueGrey,
      canvasColor: Colors.transparent),
  AppThemes.SunRise: ThemeData(
      primaryColorLight: Color(0xFFff5e62),
      primaryColor: Color(0xFFffa77b),
      primarySwatch: Colors.blueGrey,
      canvasColor: Colors.transparent),
  AppThemes.NewLeaf: ThemeData(
      primaryColorLight: Color(0xFF96e6a1),
      primaryColor: Color(0xFFd4fc79),
      primarySwatch: Colors.blueGrey,
      canvasColor: Colors.transparent),
  AppThemes.MetalGreen: ThemeData(
      primaryColorLight: Color(0xFF8fd3f4),
      primaryColor: Color(0xFF84fab0),
      primarySwatch: Colors.blueGrey,
      canvasColor: Colors.transparent),
  AppThemes.GreenApple: ThemeData(
      primaryColorLight: Color(0xFFfbed96),
      primaryColor: Color(0xFFabecd6),
      primarySwatch: Colors.blueGrey,
      canvasColor: Colors.transparent),
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
