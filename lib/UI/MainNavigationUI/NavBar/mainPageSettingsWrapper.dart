import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/UI/MainNavigationUI/Settings.dart';
import 'package:flutter/material.dart';
import '../mainPage.dart';
import 'animatedBottomBar.dart';

class BottomBarAndScaffold extends StatefulWidget {
  final Function onMenuTap;
  final bool border;

  BottomBarAndScaffold({Key key, this.border, this.onMenuTap})
      : super(key: key);

  List<BarItem> barItems = [
    BarItem(title: 'Home', iconData: Icons.home, color: Colors.blueAccent[100]),
    BarItem(
        title: 'Settings',
        iconData: Icons.settings,
        color: Colors.blueAccent[100])
  ];

  @override
  _BottomBarAndScaffoldState createState() => _BottomBarAndScaffoldState();
}

class _BottomBarAndScaffoldState extends State<BottomBarAndScaffold> {
  int SelectedBar = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: widget.border
              ? BorderRadius.circular(40)
              : BorderRadius.circular(0)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SelectedBar == 0
            ? MainPage(
              onMenuTap: widget.onMenuTap,
            )
            : SettingsPage(),
        bottomNavigationBar: AnimatedBottomBar(
          border: widget.border,
          barItems: widget.barItems,
          animationDuration: Duration(milliseconds: 150),
          onBarTap: (index) {
            setState(() {
              SelectedBar = index;
            });
          },
        ),
      ),
    );
  }
}