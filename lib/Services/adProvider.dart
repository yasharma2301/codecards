import 'package:codecards/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;

class HintCounter with ChangeNotifier {
  int _counter = prefs.getInt(hintKey);

  HintCounter(this._counter);

  getHint() {
    return _counter;
  }

  setHint() async {
    prefs = await SharedPreferences.getInstance();
    int cur = prefs.getInt(hintKey);
    prefs.setInt(hintKey, cur + 1);
    _counter = prefs.getInt(hintKey);
    notifyListeners();
  }
}
