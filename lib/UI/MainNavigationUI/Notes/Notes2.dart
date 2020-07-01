import 'package:codecards/UI/MainNavigationUI/Notes/notes_list.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Notes2 extends StatefulWidget {
  createState() => Notes2State();
}

class Notes2State extends State<Notes2> {
  final PageController ctrl = PageController(viewportFraction: 0.8);

  Stream slides;
  int currentPage = 0;

  @override
  void initState() {
    ctrl.addListener(() {
      int next = ctrl.page.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: slides,
        initialData: [],
        builder: (context, AsyncSnapshot snap) {
          //List slideList = snap.data.toList();
          List slideList = images;
          return PageView.builder(
              controller: ctrl,
              itemCount: slideList.length + 1,
              itemBuilder: (context, int currentIdx) {
                Widget returnWidget;
                if (currentIdx == 0) {
                  returnWidget = _buildTagPage();
                } else if (slideList.length >= currentIdx) {
                  bool active = currentIdx == currentPage;
                  returnWidget =
                      _buildStoryPage(slideList[currentIdx - 1], active);
                }
                return returnWidget;
              });
        });
  }
}

_buildStoryPage(String data, bool active) {
  final double blur = active ? 25 : 0;
  final double offset = active ? 25 : 0;
  final double top = active ? 240 : 320;
  return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutExpo,
      margin: EdgeInsets.only(top: top, bottom: 50, right: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('assets/image.png')),
          boxShadow: [
            BoxShadow(
                color: Colors.black87,
                blurRadius: blur,
                offset: Offset(offset, offset))
          ]),
      child: Center(
          child: Text('Note',
              style: TextStyle(fontSize: 40, color: Colors.white))));
}

_buildTagPage() {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filter The Data:',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 20,
        ),
        Text('FILTERS', style: TextStyle(color: Colors.white70)),
        _buildButton('This Week'),
        _buildButton('This Month'),
        _buildButton('Previous Month'),
      ],
    ),
  );
}

_buildButton(tag) {
  Color color = Colors.white;
  return FlatButton(
      color: color,
      onPressed: () {
        print('clicked');
      },
      child: Text('#$tag'));
}
