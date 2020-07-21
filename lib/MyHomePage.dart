import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:codecards/Shared/themes.dart';
import 'package:codecards/UI/MainNavigationUI/MenuDashboardLayout/menu_dashboard.dart';
import 'package:codecards/UI/OnBoard/onBoardNew.dart';
import 'package:codecards/UI/Settings/Avatar/avatar.dart';
import 'package:codecards/UI/Settings/Contact_US/Contact_US.dart';
import 'package:codecards/UI/Settings/settings2.dart';

class MyHomePage extends StatelessWidget {
  final String initialRoute;

  const MyHomePage({Key key, this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    Future.delayed(Duration(milliseconds: 1400));
    return MaterialApp(
      title: 'CodeCards',
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
      initialRoute: initialRoute,
      routes: {
        '/': (context) => OnBoardNew(),
        'menuDashBoard': (context) => MenuDashboardPage(),
        '/settings2': (context) => Settings(),
        'avatar': (context) => Avatar(),
        'contact_us': (context) => ContactUs()
      },
    );
  }
}
