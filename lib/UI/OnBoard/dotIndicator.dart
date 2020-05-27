import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';

class SlideDots extends StatelessWidget {
    bool isActive;
    SlideDots(this.isActive);

    @override
    Widget build(BuildContext context) {
        return AnimatedContainer(
            duration: Duration(milliseconds: 150),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            height: isActive ? 6 : 6,
            width: isActive ? 30 : 6,
            decoration: BoxDecoration(
                color: isActive ? Colors.white70 : Colors.white24,
                borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
        );
    }
}
