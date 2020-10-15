import 'dart:math' as math;
import 'package:codecards/Services/Themes/lightDarkThemeProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:codecards/Services/signupSignin/userRepository.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/UI/MainNavigationUI/Bloc/navigation_bloc.dart';
import 'menu_item.dart';

class Menu extends StatefulWidget {
  final Animation<Offset> slideAnimation;
  final Animation<double> menuScaleAnimation;
  final Function onMenuItemClicked;
  final int isSelected;
  final Function onMenuTap;
  final bool isCollapsed;
  final Future<bool> onBackTap;

  const Menu(
      {Key key,
      this.slideAnimation,
      this.menuScaleAnimation,
      this.onMenuItemClicked,
      this.isSelected,
      this.isCollapsed,
      this.onMenuTap,
      this.onBackTap})
      : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Future<bool> _onWillPop() async {
    if (widget.isCollapsed == false) {
      widget.onMenuItemClicked();
      return false;
    } else {
      return true;
    }
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  @override
  Widget build(BuildContext context) {
    final darkTheme = Provider.of<LightOrDarkTheme>(context);
    final UserRepository _userProvider = Provider.of<UserRepository>(context);
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SlideTransition(
        position: widget.slideAnimation,
        child: ScaleTransition(
          scale: widget.menuScaleAnimation,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Stack(
              children: [
                Positioned(
                  top: 60,
                  left: 15,
                  child: Text(
                    'Good ${greeting()}!\n${_userProvider.getUserName()}',
                    style: TextStyle(
                      color: darkTheme.getMode() == true ? White : Black,
                      fontSize: 22,
                      letterSpacing: 1.3,
                      fontWeight: FontWeight.w300
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Menuitem(
                          isCollapsed: widget.isCollapsed,
                          onMenuItemClicked: widget.onMenuItemClicked,
                          isSelected: widget.isSelected,
                          title: "CodeCards",
                          itemNumber: 0,
                          navigateTo: NavigationEvents.CodeCardsClickEvent,
                          icon: Icons.code,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Menuitem(
                          isCollapsed: widget.isCollapsed,
                          onMenuItemClicked: widget.onMenuItemClicked,
                          isSelected: widget.isSelected,
                          title: "Bookmarks",
                          itemNumber: 1,
                          navigateTo: NavigationEvents.BookmarksClickEvent,
                          icon: Icons.bookmark_border,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Menuitem(
                          isCollapsed: widget.isCollapsed,
                          onMenuItemClicked: widget.onMenuItemClicked,
                          isSelected: widget.isSelected,
                          title: "Community",
                          itemNumber: 2,
                          navigateTo: NavigationEvents.CommunityClickEvent,
                          icon: Icons.group,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Menuitem(
                          isCollapsed: widget.isCollapsed,
                          onMenuItemClicked: widget.onMenuItemClicked,
                          isSelected: widget.isSelected,
                          title: "Contests",
                          itemNumber: 4,
                          navigateTo: NavigationEvents.ContributeClickEvent,
                          icon: Icons.send,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Menuitem(
                          isCollapsed: widget.isCollapsed,
                          onMenuItemClicked: widget.onMenuItemClicked,
                          isSelected: widget.isSelected,
                          title: "Settings",
                          itemNumber: 3,
                          navigateTo: NavigationEvents.PremiumClickEvent,
                          icon: Icons.settings,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          height: 0.5,
                          width: MediaQuery.of(context).size.width * 0.45,
                          color: darkTheme.getMode() == true
                              ? White.withOpacity(0.35)
                              : Colors.grey[600],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(
                                  _userProvider.getUserAvatar() ??
                                      'assets/images/code.png',
                                ),
                                fit: BoxFit.fill),
                            border: Border.all(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.6))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: widget.isCollapsed
                            ? null
                            : () async {
                                if (await Vibration.hasVibrator()) {
                                  Vibration.vibrate(duration: 5);
                                }
                                _userProvider.userLogout();
                                Navigator.pushNamed(context, '/');
                              },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Transform.rotate(
                              angle: math.pi,
                              child: Icon(
                                Icons.exit_to_app,
                                color: Theme.of(context).primaryColor,
                                size: 21,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Logout",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 19),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
