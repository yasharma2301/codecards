import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'package:codecards/MyHomePage.dart';
import 'package:codecards/Shared/themes.dart';
import 'package:codecards/Services/AdProvider/adProvider.dart';
import 'package:codecards/Services/cardsServices/cardsProvider.dart';
import 'package:codecards/Services/notesServices/noteData.dart';
import 'package:codecards/Services/signupSignin/userRepository.dart';

class MyApp extends StatefulWidget {
  final String initialRoute;
  final SharedPreferences prefs;

  const MyApp({Key key, this.initialRoute, this.prefs}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CardsBloc>(
          dispose: (context, bloc) => bloc.dispose(),
          create: (BuildContext context) => CardsBloc(),
        ),
        ChangeNotifierProvider<CardsProvider>(
          create: (_) => CardsProvider(),
        ),
        ChangeNotifierProvider<NoteData>(
          create: (_) => NoteData(),
        ),
        ChangeNotifierProvider<ThemeChanger>(
          create: (_) =>
              ThemeChanger(appThemeData[widget.prefs.getString('themeKey')]),
        ),
        ChangeNotifierProvider<UserRepository>(
          create: (_) => UserRepository(
            userEmail: widget.prefs.getString('userEmail'),
            userName: widget.prefs.getString('userName'),
            userAvatar: widget.prefs.getString('userAvatar'),
            userToken: widget.prefs.getString('userToken'),
          ),
        ),
        ChangeNotifierProvider<HintCounter>(
          create: (_) => HintCounter(widget.prefs.getInt('hint')),
        )
      ],
      child: Builder(builder: (BuildContext context) {
        return MyHomePage(initialRoute: widget.initialRoute);
      }),
    );
  }
}
