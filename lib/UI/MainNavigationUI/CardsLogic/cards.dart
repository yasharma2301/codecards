import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';


class CardsStack extends StatefulWidget {
  @override
  _CardsStackState createState() => _CardsStackState();
}

class _CardsStackState extends State<CardsStack>
    with TickerProviderStateMixin {
  List<String> welcomeImages = [
    "assets/image.png",
    "assets/image.png",
    "assets/image.png",
    "assets/image.png",
    "assets/image.png",
    "assets/image.png",
    "assets/image.png",
    "assets/image.png",
  ];

  @override
  Widget build(BuildContext context) {
    CardController controller;

    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.58,
              child: new TinderSwapCard(
                orientation: AmassOrientation.BOTTOM,
                totalNum: welcomeImages.length,
                stackNum: 3,
                swipeEdge: 4.0,
                maxWidth: MediaQuery.of(context).size.width * 0.95,
                maxHeight: MediaQuery.of(context).size.width * 0.95,
                minWidth: MediaQuery.of(context).size.width * 0.85,
                minHeight: MediaQuery.of(context).size.width * 0.85,
                cardBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: AssetImage('${welcomeImages[index]}'),
                          fit: BoxFit.fitHeight)),
                ),
                cardController: controller = CardController(),
                swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
                  /// Get swiping card's alignment
                  if (align.x < 0) {
                    //Card is LEFT swiping
                  } else if (align.x > 0) {
                    //Card is RIGHT swiping
                  }
                },
                swipeCompleteCallback:
                    (CardSwipeOrientation orientation, int index) {
                  /// Get orientation & index of swiped card!
                  print('$orientation $index');
                },
              ),
            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: [
//                FloatingActionButton(
//                  onPressed: () {
//                    controller.triggerLeft();
//                  },
//                  backgroundColor: Colors.blueAccent[100],
//                  child: Icon(Icons.thumb_down),
//                ),
//                SizedBox(
//                  width: 30,
//                ),
//                FloatingActionButton(
//                  onPressed: () {
//                    controller.triggerRight();
//                  },
//                  backgroundColor: Colors.redAccent[100],
//                  child: Icon(
//                    Icons.favorite,
//                  ),
//                ),
//              ],
//            )
          ],
        ));
  }
}
