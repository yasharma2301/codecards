import 'package:codecards/Services/Themes/lightDarkThemeProvider.dart';
import 'package:codecards/UI/MainNavigationUI/contestUi/contestList.dart';
import 'package:flutter/material.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'Bloc/navigation_bloc.dart';
import 'MenuDashboardLayout/menu_dashboard.dart';
import 'contestUi/contestTile.dart';

class ContributeQuestion extends StatelessWidget with NavigationStates {
  final Function onMenuTap;

  const ContributeQuestion({Key key, this.onMenuTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkTheme = Provider.of<LightOrDarkTheme>(context);
    var height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    var width = MediaQuery.of(context).size.width;
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
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: PopBlue.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 1)
                ],
                borderRadius: border
                    ? BorderRadius.circular(40)
                    : BorderRadius.circular(0),
                color: darkTheme.getMode() == true ? Grey : White),
            child: ClipRRect(
              borderRadius:
                  border ? BorderRadius.circular(30) : BorderRadius.circular(0),
              child: Stack(
                children: [
                  Positioned(
                    left: -(height / 2 - width / 2),
                    top: -height * 0.13,
                    child: Container(
                      height: height,
                      width: height,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: darkTheme.getMode() == true
                              ? LightGrey.withOpacity(0.15)
                              : Colors.grey.withOpacity(0.3)),
                    ),
                  ),
                  Positioned(
                    left: width * 0.15,
                    top: -width * 0.5,
                    child: Container(
                      height: width * 1.6,
                      width: width * 1.6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: darkTheme.getMode() == true
                            ? LightGrey.withOpacity(0.1)
                            : Colors.grey.withOpacity(0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -width * 0.2,
                    top: -50,
                    child: Container(
                      height: width * 0.6,
                      width: width * 0.6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: darkTheme.getMode() == true
                            ? LightGrey.withOpacity(0.1)
                            : Colors.grey.withOpacity(0.1),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: padding.top - 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: border == true
                                ? EdgeInsets.only(left: 10)
                                : EdgeInsets.only(left: 5),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Contests',
                                      style: TextStyle(
                                          color: darkTheme.getMode() == true
                                              ? White
                                              : Grey,
                                          fontSize: 23,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 45),
                                  child: Container(
                                    width: width,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: border ? 10 : 0),
                                      child: ContestList(),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 45,
                                    width: width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(top: BorderSide(width: 1,color: Colors.grey))
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'SORT',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 18),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Icon(
                                                  Icons.sort,
                                                  size: 24,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 1,
                                          height: 30,
                                          color: Colors.grey,
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'FILTER',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 18),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Icon(
                                                  FontAwesomeIcons.filter,
                                                  size: 16,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: padding.top + 5,
                    child: GestureDetector(
                      onTap: onMenuTap,
                      child: Material(
                        elevation: 30,
                        child: Container(
                          height: 40,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(10)),
                            color: darkTheme.getMode() == true ? Grey : White,
                          ),
                          child: Icon(
                            Icons.menu,
                            color: darkTheme.getMode() == true
                                ? Colors.white
                                : Grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
