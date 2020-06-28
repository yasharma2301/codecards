import 'package:codecards/Shared/Colors.dart';

import 'Bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';

import 'MenuDashboardLayout/menu_dashboard.dart';
final Color backGroundColor = Color(0xFF1c2129);

class RateUs extends StatelessWidget with NavigationStates{
  final Function onMenuTap;
  const RateUs({Key key, this.onMenuTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()  {
        return Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> MenuDashboardPage()));
      },
      child: LayoutBuilder(
        builder: (context,constraints){
          double currentWidth = constraints.constrainWidth();
          double maxWidth = MediaQuery.of(context).size.width;
          bool border;
          if(maxWidth==currentWidth){
            border=false;
          }else{
            border=true;
          }
          return Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 40),
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: PopBlue.withOpacity(0.5),blurRadius: 8,spreadRadius: 1)],
                borderRadius: border? BorderRadius.circular(40):BorderRadius.circular(0),
                color: backGroundColor
            ),
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
                          "Rate Us",
                          style: TextStyle(fontSize: 24.0, color: Colors.white),
                        ),
                      ],
                    ),
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
