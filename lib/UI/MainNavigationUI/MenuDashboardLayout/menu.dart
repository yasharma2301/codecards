import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/UI/MainNavigationUI/Bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/vibration.dart';
import 'menu_item.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import 'package:codecards/UI/Settings/Avatar/avatar_provider.dart';

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
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AvatarChanger avatarChanger = Provider.of<AvatarChanger>(context);
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SlideTransition(
        position: widget.slideAnimation,
        child: ScaleTransition(
          scale: widget.menuScaleAnimation,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: size.width / 1.75,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Menuitem(
                          isCollapsed: widget.isCollapsed,
                          onMenuItemClicked: widget.onMenuItemClicked,
                          isSelected: widget.isSelected,
                          title: "Code Cards",
                          itemNumber: 0,
                          navigateTo: NavigationEvents.CodeCardsClickEvent,
                          icon: Icons.content_copy,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        // GestureDetector(
                        //   onTap: widget.isCollapsed
                        //       ? null
                        //       : () async {
                        //           BlocProvider.of<NavigationBloc>(context).add(
                        //               NavigationEvents.BookmarksClickEvent);
                        //           if (await Vibration.hasVibrator()) {
                        //             Vibration.vibrate(duration: 5);
                        //           }
                        //           widget.onMenuItemClicked();
                        //         },
                        //   child: Text(
                        //     "Bookmarks",
                        //     style: TextStyle(
                        //       color: Theme.of(context).primaryColor,
                        //       fontSize: widget.isSelected == 1 ? 22 : 20,
                        //       fontWeight: widget.isSelected == 1
                        //           ? FontWeight.bold
                        //           : FontWeight.normal,
                        //     ),
                        //   ),
                        // ),
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
                        // GestureDetector(
                        //   onTap: widget.isCollapsed
                        //       ? null
                        //       : () async {
                        //           BlocProvider.of<NavigationBloc>(context).add(
                        //               NavigationEvents.CommunityClickEvent);
                        //           if (await Vibration.hasVibrator()) {
                        //             Vibration.vibrate(duration: 5);
                        //           }
                        //           widget.onMenuItemClicked();
                        //         },
                        //   child: Text(
                        //     "Community",
                        //     style: TextStyle(
                        //       color: Theme.of(context).primaryColor,
                        //       fontSize: widget.isSelected == 2 ? 22 : 20,
                        //       fontWeight: widget.isSelected == 2
                        //           ? FontWeight.bold
                        //           : FontWeight.normal,
                        //     ),
                        //   ),
                        // ),
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
                        // GestureDetector(
                        //   onTap: widget.isCollapsed
                        //       ? null
                        //       : () async {
                        //           BlocProvider.of<NavigationBloc>(context).add(
                        //               NavigationEvents
                        //                   .DeveloperStoryClickEvent);
                        //           if (await Vibration.hasVibrator()) {
                        //             Vibration.vibrate(duration: 5);
                        //           }
                        //           widget.onMenuItemClicked();
                        //         },
                        //   child: Text(
                        //     "Developer Story",
                        //     style: TextStyle(
                        //       color: Theme.of(context).primaryColor,
                        //       fontSize: widget.isSelected == 4 ? 22 : 20,
                        //       fontWeight: widget.isSelected == 4
                        //           ? FontWeight.bold
                        //           : FontWeight.normal,
                        //     ),
                        //   ),
                        // ),
                        Menuitem(
                          isCollapsed: widget.isCollapsed,
                          onMenuItemClicked: widget.onMenuItemClicked,
                          isSelected: widget.isSelected,
                          title: "Developer Story",
                          itemNumber: 4,
                          navigateTo: NavigationEvents.DeveloperStoryClickEvent,
                          icon: Icons.code,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Menuitem(
                          isCollapsed: widget.isCollapsed,
                          onMenuItemClicked: widget.onMenuItemClicked,
                          isSelected: widget.isSelected,
                          title: "Support",
                          itemNumber: 5,
                          navigateTo: NavigationEvents.DeveloperStoryClickEvent,
                          icon: Icons.headset_mic,
                        ),
                        Divider(
                          height: 50,
                          color: White.withOpacity(0.4),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: -50,
                    child: Container(
                      width: size.width / 1.75,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(100),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Theme.of(context)
                                        .primaryColorLight
                                        .withOpacity(0.6))),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                avatarChanger.getAvatar(),
                                height: 120,
                                width: 120,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.perm_identity,
                                color: Theme.of(context).primaryColor,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Username",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: widget.isCollapsed
                                ? null
                                : () async {
                                    if (await Vibration.hasVibrator()) {
                                      Vibration.vibrate(duration: 5);
                                    }
                                  },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Transform.rotate(
                                  angle: math.pi,
                                  child: Icon(
                                    Icons.exit_to_app,
                                    color: Theme.of(context).primaryColor,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Logout",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
