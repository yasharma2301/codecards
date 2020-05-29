import 'package:codecards/Shared/Colors.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'SlideList.dart';

class Items extends StatelessWidget {
  final int index;
  final Color color;

  const Items(this.index, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Container(
          height: 500,
          width: 500,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    SlideList[index].title,
                    style: TextStyle(
                        fontSize: 28,
                        color: White,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
                child: FlareActor(
                  SlideList[index].flare,
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.contain,
                  animation: SlideList[index].animation,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
