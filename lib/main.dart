import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:codecards/MyApp.dart';
import 'package:codecards/Services/notesServices/noteModel.dart';

SharedPreferences prefs;
const String hintKey = 'hint';
const String lightOrDarkTheme = 'lightDark';
const darkModeBox = 'darkModeTutorial';
const mode = 'mode';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox(darkModeBox);
  if (Hive.box(darkModeBox).get(mode) == null) {
    Hive.box(darkModeBox).put(mode, true);
  }
  Hive.registerAdapter(NoteModelAdapter());
  Admob.initialize("com.example.codecards");
  prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey(hintKey)) {
    await prefs.setInt(hintKey, 0);
  }
  if (!prefs.containsKey('themeKey')) {
    await prefs.setString('themeKey', "AppThemes.BluePop");
  }
  await _checkInitialRoute().then((value) {
    runApp(
      MyApp(
        initialRoute: value ? 'menuDashBoard' : '/',
        prefs: prefs,
      ),
    );
  });
}

Future<bool> _checkInitialRoute() async {
  SharedPreferences _sprefs = await SharedPreferences.getInstance();
  return _sprefs.containsKey('userToken');
}
