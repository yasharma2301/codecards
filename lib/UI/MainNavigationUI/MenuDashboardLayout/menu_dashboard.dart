import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:codecards/UI/MainNavigationUI/Bloc/navigation_bloc.dart';
import 'dashboard.dart';
import 'menu.dart';
import '../bookmarks.dart';
import '../code_cards.dart';
import '../community.dart';
import '../developer_story.dart';
import '../rate_us.dart';

final Color backGroundColor = Color(0xFF1c2129);

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<Offset> _slideAnimation;
  Animation<double> _borderAnimation;
  Animation<double> _menuScaleAnimation;

  void onMenuTap() {
    setState(() {
      if (isCollapsed) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      isCollapsed = !isCollapsed;
    });
  }

  void onMenuItemClicked() {
    setState(() {
      _controller.reverse();
    });
    isCollapsed = !isCollapsed;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
    _borderAnimation = Tween<double>(begin: 0, end: 40).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 1, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backGroundColor,
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(onMenuTap: onMenuTap),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationStates>(
                builder: (context, NavigationStates navigationStates) {
              return Menu(
                onMenuTap: onMenuTap,
                isCollapsed: isCollapsed,
                slideAnimation: _slideAnimation,
                menuScaleAnimation: _menuScaleAnimation,
                onMenuItemClicked: onMenuItemClicked,
                isSelected: findSelected(navigationStates),
              );
            }),
            Dashboard(
              duration: duration,
              anim: _controller,
              onMenuTap: onMenuTap,
              borderAnimation: _borderAnimation,
              isCollapsed: isCollapsed,
              screenWidth: screenWidth,
              scaleAnimation: _scaleAnimation,
              child: BlocBuilder<NavigationBloc, NavigationStates>(
                builder: (
                  context,
                  NavigationStates navigationState,
                ) {
                  return navigationState as Widget;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  int findSelected(NavigationStates navigationStates) {
    if (navigationStates is CodeCards) {
      return 0;
    } else if (navigationStates is BookMarks) {
      return 1;
    } else if (navigationStates is Community) {
      return 2;
    } else if (navigationStates is RateUs) {
      return 3;
    } else if (navigationStates is DeveloperStory) {
      return 4;
    } else {
      return 0;
    }
  }
}
