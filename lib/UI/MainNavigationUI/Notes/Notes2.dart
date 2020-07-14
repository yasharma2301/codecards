import 'package:codecards/Services/notesServices/noteInherited.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/rendering.dart';

class Notes2 extends StatefulWidget {
  createState() => Notes2State();
}

class Notes2State extends State<Notes2> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  final PageController ctrl = PageController(viewportFraction: 0.92);

  int currentPage = 0;
  double width;

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

    width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FlatButton(
          child: Container(
            color: Colors.white,
            height: 50,
            width: width / 2,
            child: Center(
              child: Text(
                'Add a note',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Container(
            height: MediaQuery.of(context).size.height / 1.45,
            child: FutureBuilder(
             // future: NoteProvider.getNoteList(),
              builder: (context, AsyncSnapshot snap) {
                final notes = snap.data;
                if (snap.hasData) {
                  return PageView.builder(
                    controller: ctrl,
                    itemCount: notes.length + 1,
                    itemBuilder: (context, int currentIdx) {
                      Widget returnWidget;
                      if (currentIdx == 0) {
                        returnWidget = _buildTagPage();
                      } else if (notes.length >= currentIdx) {
                        bool active = currentIdx == currentPage;
                        returnWidget = _buildStoryPage(
                            notes[currentIdx - 1], active, width, context,ctrl,currentIdx);
                      }
                      return returnWidget;
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(strokeWidth: 1,),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

_buildStoryPage(Map<String, dynamic> data, bool active, double width,
    BuildContext context,PageController ctrl,currentIdx) {
  final double blur = active ? 30 : 0;
  final double offset = active ? 15 : 0;
  final double top = active ? 60 : 85;
  return GestureDetector(
    child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOutExpo,
        margin: EdgeInsets.only(top: top, bottom: 50, right: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('assets/image.png')),
            boxShadow: [
              BoxShadow(
                  color: Colors.black87,
                  blurRadius: blur,
                  offset: Offset(offset, offset))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.delete,
                color: CupertinoColors.black,
                size: 40,
              ),
            ),
            Text(data['title'],
                style: TextStyle(fontSize: 40, color: Colors.white)),
            Text(data['description'],
                style: TextStyle(fontSize: 20, color: Colors.white)),
          ],
        )),
  );
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
        _buildButton('This Week', () {}),
        _buildButton('This Month', () {}),
        _buildButton('Previous Month', () {
          print('abc');
        }),
      ],
    ),
  );
}

_buildButton(tag, onPressed) {
  Color color = Colors.white;
  return FlatButton(color: color, onPressed: onPressed, child: Text('#$tag'));
}
