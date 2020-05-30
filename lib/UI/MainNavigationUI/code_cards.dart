import 'package:flutter/material.dart';

import 'Bloc/navigation_bloc.dart';
final Color backGroundColor = Color(0xFF1c2129);

class CodeCards extends StatelessWidget with NavigationStates{
  final Function onMenuTap;
  const CodeCards({Key key, this.onMenuTap}) : super(key: key);

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
                        "My Cards",
                        style: TextStyle(fontSize: 24.0, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Container(
                    height: 200,
                    child: PageView(
                      controller: PageController(viewportFraction: 0.8),
                      scrollDirection: Axis.horizontal,
                      pageSnapping: true,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.redAccent,
                          width: 100,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.blueAccent,
                          width: 100,
                        ), Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.greenAccent,
                          width: 100,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Text('Temporary Cards', style: TextStyle(color: Colors.white),),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
