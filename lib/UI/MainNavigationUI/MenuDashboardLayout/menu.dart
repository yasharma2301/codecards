import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/UI/MainNavigationUI/Bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Menu extends StatelessWidget {
  final Animation<Offset> slideAnimation;
  final Animation<double> menuScaleAnimation;
  final Function onMenuItemClicked;
  final int isSelected;

  const Menu(
      {Key key,
      this.slideAnimation,
      this.menuScaleAnimation,
      this.onMenuItemClicked,
      this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: ScaleTransition(
        scale: menuScaleAnimation,
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
                          onMenuItemClicked();
                        },
                        child: Text(
                          "Code Cards",
                          style: TextStyle(
                            color: PopBlue,
                            fontSize: isSelected == 0 ? 22 : 20,
                            fontWeight: isSelected == 0
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
                          onMenuItemClicked();
                        },
                        child: Text(
                          "Bookmarks",
                          style: TextStyle(
                            color: PopBlue,
                            fontSize: isSelected == 1 ? 22 : 20,
                            fontWeight: isSelected == 1
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
                          onMenuItemClicked();
                        },
                        child: Text(
                          "Community",
                          style: TextStyle(
                            color: PopBlue,
                            fontSize: isSelected == 2 ? 22 : 20,
                            fontWeight: isSelected == 2
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
                          onMenuItemClicked();
                        },
                        child: Text(
                          "Rate Us",
                          style: TextStyle(
                            color: PopBlue,
                            fontSize: isSelected == 3 ? 22 : 20,
                            fontWeight: isSelected == 3
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
                          onMenuItemClicked();
                        },
                        child: Text(
                          "Developer Story",
                          style: TextStyle(
                            color: PopBlue,
                            fontSize: isSelected == 4 ? 22 : 20,
                            fontWeight: isSelected == 4
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
    );
  }
}
