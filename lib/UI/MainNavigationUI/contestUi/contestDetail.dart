import 'dart:math';

import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContestDetail extends StatefulWidget {
  @override
  _ContestDetailState createState() => _ContestDetailState();
}

class _ContestDetailState extends State<ContestDetail>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    var height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Container(
            height: height * 0.9,
            width: width,
            decoration: BoxDecoration(
              color: Grey,
            ),
            child: Center(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: padding.top,horizontal: 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: White,
                          ), onPressed: () { Navigator.of(context).pop(); },
                        )
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.code,
                        size: 300,
                        color: White.withOpacity(0.02),
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                        top: padding.top + 20,
                        left: 20,
                        right: 20,
                        bottom: padding.top),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              'October Long Challenge',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontFamily: 'Montserrat'),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'Until Start :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontFamily: 'Montserrat'),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '30:25:12',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 44,
                                  color: Colors.white,
                                  fontFamily: 'Montserrat'),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'START:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontFamily: 'Montserrat'),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        '2020-10-16',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.green,
                                            fontFamily: 'Montserrat'),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        '21:30:00',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.green,
                                            fontFamily: 'Montserrat'),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'END:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontFamily: 'Montserrat'),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        '2020-10-16',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.green,
                                            fontFamily: 'Montserrat'),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        '21:30:00',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.green,
                                            fontFamily: 'Montserrat'),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Duration: 3 hours',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontFamily: 'Montserrat'),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'Host: codechef.com',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontFamily: 'Montserrat'),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Link to contest',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.blueAccent[100],
                                      fontFamily: 'Montserrat'),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Transform.rotate(
                                  angle: -pi / 3,
                                  child: Icon(
                                    Icons.link,
                                    size: 18,
                                    color: Colors.blueAccent[100],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.85,
            left: width * 0.1,
            child: GestureDetector(
              onTap: () {
                print('click');
              },
              onTapDown: _onTapDown,
              onTapUp: _onTapUp,
              child: Transform.scale(
                scale: _scale,
                child: Container(
                  height: 60,
                  width: width - width * 0.2,
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Grey.withOpacity(0.5),
                          blurRadius: 10.0,
                          offset: Offset(0.0, 5))
                    ],
                    borderRadius: BorderRadius.circular(50),
                    gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColorLight
                        ],
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.topRight,
                        tileMode: TileMode.repeated),
                  ),
                  child: Center(
                    child: Text(
                      'Add A Reminder',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                'Add a reminder and we\'ll send you an e-mail an hour before the contest starts.',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
