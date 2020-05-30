import 'Bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
final Color backGroundColor = Color(0xFF1c2129);

class Community extends StatelessWidget with NavigationStates{
  final Function onMenuTap;
  const Community({Key key, this.onMenuTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){
        double CurrentWidth = constraints.constrainWidth();
        double MaxWidth = MediaQuery.of(context).size.width;
        bool border;
        if(MaxWidth==CurrentWidth){
          border=false;
        }else{
          border=true;
        }
        return Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 40),
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.5),blurRadius: 8,spreadRadius: 1)],
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
                      InkWell(
                          child: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          onTap: onMenuTap
                      ),
                      Text(
                        "Community",
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
    );
  }
}
