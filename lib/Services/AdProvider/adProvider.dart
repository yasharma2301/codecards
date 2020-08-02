import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:codecards/main.dart';

class HintCounter with ChangeNotifier {
  int _counter = prefs.getInt(hintKey);

  HintCounter(this._counter);

  getHint() {
    return _counter;
  }

  increaseHints() async {
    prefs = await SharedPreferences.getInstance();
    int cur = prefs.getInt(hintKey);
    prefs.setInt(hintKey, cur + 1);
    _counter = prefs.getInt(hintKey);
    notifyListeners();
  }

  decreaseHints() async {
    if (_counter > 0) {
      prefs = await SharedPreferences.getInstance();
      int cur = prefs.getInt(hintKey);
      prefs.setInt(hintKey, cur - 1);
      _counter = prefs.getInt(hintKey);
      notifyListeners();
    }
  }
}
