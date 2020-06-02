import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/UI/MainNavigationUI/Notes/note_cards_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'addNoteCards.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> with SingleTickerProviderStateMixin {
  Animation<Color> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.easeOut);
    animation = ColorTween(end: LightGrey, begin: LightPopBlue.withOpacity(0.5))
        .animate(curve);
    animation.addStatusListener((status) {
      controller.repeat();
      setState(() {});
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Grey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: animation,
                    builder: (BuildContext context, Widget child) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            controller.forward();
                          });
                        },
                        child: Text(
                          'Hey You!',
                          style: TextStyle(
                              color: animation.value,
                              fontSize: 36,
                              fontFamily: 'Nunito Black'),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 12,
                    child: Text(
                      'Add a note for quick access.',
                      style: TextStyle(
                          color: LightGrey.withOpacity(0.5),
                          fontSize: 22,
                          fontFamily: 'Nunito Black'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AddCard(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            child: Container(
                height: 350,
                width: 450,
                child: NoteCardsStack()),
          ),
        ],
      ),
    );
  }
}


