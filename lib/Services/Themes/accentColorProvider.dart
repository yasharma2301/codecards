import 'package:codecards/Shared/themesEnum.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;

  ThemeChanger(_themeData) {
    this._themeData = _themeData;
  }

  getTheme() => _themeData;

  setTheme(ThemeData theme) {
    appThemeData.forEach((key, value) {
      if (value == theme) {
        saveTheme(key);
      }
    });
    _themeData = theme;
    notifyListeners();
  }

  Future<void> saveTheme(themeKey) async {
    SharedPreferences _sprefs = await SharedPreferences.getInstance();
    _sprefs.setString('themeKey', themeKey);
    notifyListeners();
  }
}
