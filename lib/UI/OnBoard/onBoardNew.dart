import 'dart:async';
import 'package:codecards/UI/OnBoard/slideItems.dart';
import 'package:codecards/UI/OnBoard/slide_details.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/UI/OnBoard/Login/newLoginPage.dart';
import 'dots.dart';

class OnBoardNew extends StatefulWidget {
  @override
  _OnBoardNewState createState() => _OnBoardNewState();
}

class _OnBoardNewState extends State<OnBoardNew> with  SingleTickerProviderStateMixin {
double _scale;
AnimationController _controller;
int _currentPage = 0;
final PageController _pageController = PageController(initialPage: 0);
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
  Timer.periodic(Duration(seconds: 5), (Timer timer) {
    if (_currentPage < 2) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }
  });
  if (_pageController.hasClients) {
    _pageController.animateToPage(_currentPage,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }
  super.initState();
}

@override
void dispose() {
  super.dispose();
  _pageController.dispose();
  _controller.dispose();
}
_onPageChanged(int index) {
  setState(() {
    _currentPage = index;
  });
}

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: Grey,
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
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: padding.top+60,bottom: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "CODECARDS",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Colors.white,
                          fontFamily: 'Montserrat'),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: width,
                      height: height*0.6,
                      child:Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          PageView.builder(
                            onPageChanged: _onPageChanged,
                            controller: _pageController,
                            scrollDirection: Axis.horizontal,
                            itemCount: SlideList.length,
                            itemBuilder: (context, index) => Items(index),
                          ),
                          Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                for (int i = 0; i < SlideList.length; i++)
                                  if (i == _currentPage)
                                    SlideDots(true)
                                  else
                                    SlideDots(false)
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.85,
            left: width * 0.1,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: RegisterPage()));
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
                      'Let\'s start!',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
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
                'We are happy to see you here!\n Hope you like the journey with us.',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      )
    );
  }
  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
