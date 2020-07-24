import 'package:flutter/material.dart';
import 'Bloc/navigation_bloc.dart';

import 'package:codecards/Shared/Colors.dart';
import 'Bookmarks/BookmarksListing.dart';
import 'MenuDashboardLayout/menu_dashboard.dart';

final Color backGroundColor = Color(0xFF1c2129);

class BookMarks extends StatelessWidget with NavigationStates {
  final Function onMenuTap;

  const BookMarks({Key key, this.onMenuTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MenuDashboardPage()));
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          double currentWidth = constraints.constrainWidth();
          double maxWidth = MediaQuery.of(context).size.width;
          bool border;
          if (maxWidth == currentWidth) {
            border = false;
          } else {
            border = true;
          }
          return Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 40),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color:
                          Theme.of(context).primaryColorLight.withOpacity(0.6),
                      blurRadius: 6,
                      spreadRadius: 0.5)
                ],
                borderRadius: border
                    ? BorderRadius.circular(40)
                    : BorderRadius.circular(0),
                color: backGroundColor),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          splashColor: LightPopBlue.withOpacity(0.8),
                          hoverColor: LightPopBlue,
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: onMenuTap,
                        ),
                        Text(
                          "BookMarks",
                          style: TextStyle(fontSize: 24.0, color: Colors.white),
                        ),
                      ],
                    ),
                    BookmarksListing(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
