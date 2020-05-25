import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';
import 'SlideList.dart';

class Items extends StatelessWidget {
  final int index;
  final Color color;

  const Items(this.index,this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        color: color,
        elevation: 10,
        child: (Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              SlideList[index].title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                color: Black,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              SlideList[index].description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Black,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
