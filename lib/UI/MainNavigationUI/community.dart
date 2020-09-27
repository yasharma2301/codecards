import 'package:codecards/Services/Themes/lightDarkThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/Shared/delayed_animation.dart';
import 'package:provider/provider.dart';
import 'package:swipedetector/swipedetector.dart';
import 'Bloc/navigation_bloc.dart';
import 'MenuDashboardLayout/menu_dashboard.dart';

final Color backGroundColor = Color(0xFF1c2129);

class Community extends StatelessWidget with NavigationStates {
  final Function onMenuTap;

  const Community({Key key, this.onMenuTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var padding = MediaQuery.of(context).padding;
    final darkTheme = Provider.of<LightOrDarkTheme>(context);
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
          return SwipeDetector(
            onSwipeRight: onMenuTap,
            swipeConfiguration: SwipeConfiguration(
                horizontalSwipeMinDisplacement: 30
            ),
            child: ClipRRect(
              borderRadius:
              border ? BorderRadius.circular(30) : BorderRadius.circular(0),
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: PopBlue.withOpacity(0.5),
                          blurRadius: 8,
                          spreadRadius: 1)
                    ],
                    borderRadius: border
                        ? BorderRadius.circular(30)
                        : BorderRadius.circular(0),
                    color: darkTheme.getMode() == true ?Grey:White),
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
                        padding: EdgeInsets.only(top: padding.top-5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: border == true
                                  ? EdgeInsets.only(left: 10)
                                  : EdgeInsets.only(left: 5),
                              child: Stack(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        splashColor: LightPopBlue.withOpacity(0.8),
                                        hoverColor: LightPopBlue,
                                        icon: Icon(
                                          Icons.menu,
                                          color: darkTheme.getMode() == true ?White:Grey,
                                          size: 30,
                                        ),
                                        onPressed: onMenuTap,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        'Community',
                                        style: TextStyle(
                                          color: darkTheme.getMode() == true ?White:Grey,
                                          fontSize: 23,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                height: MediaQuery.of(context).size.height - 130,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 15,
                                        child: Card1(),
                                      ),
                                      Positioned(right: 10, top: 255, child: Card2()),
                                      Positioned(
                                        left: 0,
                                        top: 440,
                                        child: Card3(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
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

class Card1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final darkTheme = Provider.of<LightOrDarkTheme>(context);
    return DelayedAnimation(
      delay: 50,
      child: Container(
        height: MediaQuery.of(context).size.height / 2.4,
        width: MediaQuery.of(context).size.width - 15,
        decoration: BoxDecoration(
          color: White,
          boxShadow: [
            BoxShadow(
                color: Colors.white30,
                offset: Offset(4.0, 4.0),
                blurRadius: 10.0,
                spreadRadius: 0.5),
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 6, left: 6, bottom: 6),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFFF2994A).withOpacity(0.95),
                    Color(0xFFF2C94C).withOpacity(0.9)
                  ],
                  stops: [
                    0.1,
                    0.99
                  ],
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.topRight,
                  tileMode: TileMode.repeated),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/workflow.png'),
                            fit: BoxFit.cover)),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Coming Soon!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Discover\nArticles, Solved\nquestions\nand more.',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Card2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final darkTheme = Provider.of<LightOrDarkTheme>(context);
    return DelayedAnimation(
      delay: 350,
      child: Container(
        height: MediaQuery.of(context).size.height / 3.2,
        width: 226,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.white30,
                  offset: Offset(4.0, 4.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.5),
            ],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color:  Colors.white, width: 3, style: BorderStyle.solid)),
        child: Container(
          height: 220,
          width: 220,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF3C4869).withOpacity(0.8), Color(0xFFAEC5E6)],
                stops: [0.1, 0.99],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.topRight,
                tileMode: TileMode.repeated),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 15,
                left: 15,
                child: Text(
                  'Ask\nPersonalised\nQuestions',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
              Positioned(
                bottom: 70,
                left: 15,
                child: Text(
                  'Get your\nqueries solved in\nminimal time.',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.left,
                ),
              ),
              Positioned(
                bottom: 20,
                right: 0,
                child: Container(
                  height: 125,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      border: Border.all(
                          color: Colors.white,
                          width: 3,
                          style: BorderStyle.solid)),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        left: 5,
                        top: 10,
                        child: Column(
                          children: [
                            Container(
                              height: 55,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5)),
                                  color: Colors.black,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/brenda.PNG'),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Brenda Smith',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 28,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent[100]
                                        .withOpacity(0.25),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Followers',
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 6,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        '243',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 6,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 28,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent[100]
                                        .withOpacity(0.25),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Articles',
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 6,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        '13',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 6,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Card3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DelayedAnimation(
      delay: 400,
      child: Container(
        height: MediaQuery.of(context).size.height / 4.7,
        width: 250,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.white30,
                  offset: Offset(4.0, 4.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.5),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: Colors.white, width: 3, style: BorderStyle.solid)),
        child: Container(
          height: 220,
          width: 220,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.pink[500].withOpacity(0.72),
                  Color(0xFFee9ca7).withOpacity(0.8)
                ],
                stops: [
                  0.1,
                  0.99
                ],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.topRight,
                tileMode: TileMode.repeated),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Positioned(
                  top: 5,
                  left: -60,
                  child: Icon(
                    Icons.lightbulb_outline,
                    color: Colors.white12,
                    size: 170,
                  )),
              Positioned(
                top: 15,
                left: 15,
                child: Text(
                  'Get the\nMost out of\nCodeCards!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
              Positioned(
                bottom: 20,
                right: 10,
                child: Text(
                  'Make rooms with\nfriends and discuss.',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
