import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import '../../main.dart';

class LightOrDarkTheme with ChangeNotifier {
  bool _darkMode = Hive.box(darkModeBox).get(mode);

  LightOrDarkTheme(this._darkMode);

  getMode() {
    return _darkMode;
  }

  void changeToLight() async{
    await Hive.box(darkModeBox).put(mode, false);
    _darkMode = false;
    notifyListeners();
  }

  void changeToDark() async{
    await Hive.box(darkModeBox).put(mode, true);
    _darkMode = true;
    notifyListeners();
  }
}
