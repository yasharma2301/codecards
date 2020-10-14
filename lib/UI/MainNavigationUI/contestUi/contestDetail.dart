import 'package:codecards/Shared/Colors.dart';
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
            child: Stack(
              children: [

              ],
            ),
          ),
          Positioned(
            top: height * 0.85,
            left: width * 0.1,
            child: GestureDetector(
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