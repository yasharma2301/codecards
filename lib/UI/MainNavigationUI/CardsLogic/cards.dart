import 'package:codecards/Services/cardsServices/cardsProvider.dart';
import 'package:codecards/Services/notesServices/noteData.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:provider/provider.dart';

class CardsStack extends StatefulWidget {
  @override
  _CardsStackState createState() => _CardsStackState();
}

class _CardsStackState extends State<CardsStack> with TickerProviderStateMixin {
  CardController _controller;
  int page = 1;
  CardController get controller => _controller;

  @override
  Widget build(BuildContext context) {
    var cardProvider = Provider.of<CardsProvider>(context,listen: false);
    return Container(
        child: FutureBuilder(
          future: cardProvider.callCards(page),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return TinderSwapCard(
                orientation: AmassOrientation.BOTTOM,
                totalNum: cardProvider.returnCardListLength(),
                stackNum: 3,
                swipeEdge: 2.0,
                maxWidth: MediaQuery.of(context).size.width,
                maxHeight: MediaQuery.of(context).size.height,
                minWidth: MediaQuery.of(context).size.width * 0.9,
                minHeight: MediaQuery.of(context).size.height * 0.95,
                cardBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    color: LightGrey,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white)
                  ),
                  child: Center(
                      child: Text(
                        cardProvider.getCardList()[index].question,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  )),
                ),
                cardController: _controller,
                swipeUpdateCallback:
                    (DragUpdateDetails details, Alignment align) {
                  /// Get swiping card's alignment
                  if (align.x < 0) {
                    ///Card is LEFT swiping
                  } else if (align.x > 0) {
                    ///Card is RIGHT swiping
                  }
                },
                swipeCompleteCallback:
                    (CardSwipeOrientation orientation, int index) {
                      if(index==5){
                        print('5th swiped');
                       // page+=1;
                      }
                  print('$orientation $index');
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              );
            }
          },
        ));
  }
}

//child: FutureBuilder(
//future: Provider.of<CardsProvider>(context).callCards(1),
//builder: (context, snapshot) {
//if(snapshot.hasData){
//return ListView.builder(
//scrollDirection: Axis.vertical,
//shrinkWrap: true,
//itemBuilder: (context, index) {
//return ListTile(subtitle: Text('a'),);
//},
//itemCount: 8
//);
//}
//else{
//return Container();
//}
//},
//),
