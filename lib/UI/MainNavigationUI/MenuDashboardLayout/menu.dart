import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/UI/MainNavigationUI/Bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SlideTransition(
        position: widget.slideAnimation,
        child: ScaleTransition(
          scale: widget.menuScaleAnimation,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.CodeCardsClickEvent);
                            widget.onMenuItemClicked();
                          },
                          child: Text(
                            "Code Cards",
                            style: TextStyle(
                              color: PopBlue,
                              fontSize: widget.isSelected == 0 ? 22 : 20,
                              fontWeight: widget.isSelected == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.BookmarksClickEvent);
                            widget.onMenuItemClicked();
                          },
                          child: Text(
                            "Bookmarks",
                            style: TextStyle(
                              color: PopBlue,
                              fontSize: widget.isSelected == 1 ? 22 : 20,
                              fontWeight: widget.isSelected == 1
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.CommunityClickEvent);
                            widget.onMenuItemClicked();
                          },
                          child: Text(
                            "Community",
                            style: TextStyle(
                              color: PopBlue,
                              fontSize: widget.isSelected == 2 ? 22 : 20,
                              fontWeight: widget.isSelected == 2
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.RateUsClickEvent);
                            widget.onMenuItemClicked();
                          },
                          child: Text(
                            "Rate Us",
                            style: TextStyle(
                              color: PopBlue,
                              fontSize: widget.isSelected == 3 ? 22 : 20,
                              fontWeight: widget.isSelected == 3
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.DeveloperStoryClickEvent);
                            widget.onMenuItemClicked();
                          },
                          child: Text(
                            "Developer Story",
                            style: TextStyle(
                              color: PopBlue,
                              fontSize: widget.isSelected == 4 ? 22 : 20,
                              fontWeight: widget.isSelected == 4
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.arrow_back_ios,
                            color: PopBlue,
                            size: 15,
                          ),
                          Text(
                            "Logout",
                            style: TextStyle(color: PopBlue, fontSize: 20),
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
