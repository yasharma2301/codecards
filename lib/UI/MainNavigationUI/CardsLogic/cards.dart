import 'package:codecards/Services/cardsServices/cardResponseModel.dart';
import 'package:codecards/Services/cardsServices/cardsProvider.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_stack/swipe_stack.dart';

class CardsStack extends StatefulWidget {
  @override
  _CardsStackState createState() => _CardsStackState();
}

class _CardsStackState extends State<CardsStack> with TickerProviderStateMixin {
  List<CardsResults> results;
  List<int> maxResults = [];

  @override
  void initState() {
    results = [];
    maxResults.addAll(List.generate(50, (index) => index));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<CardsBloc>(context);
    return Container(
      child: StreamBuilder<List<CardsResults>>(
        stream: bloc.stream,
        builder:
            (BuildContext context, AsyncSnapshot<List<CardsResults>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            );
          }
          results.addAll(snapshot.data);
          return SwipeStack(
            children: results.map(
              (CardsResults cardsResult) {
                return SwiperItem(
                  builder: (SwiperPosition position, double progress) {
                    return Material(
                      elevation: 4,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: LightGrey,
                          border: Border.all(width: 1,color: Grey),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              cardsResult.hint,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            Text(
                              cardsResult.question,
                              style: TextStyle(color: Colors.blue, fontSize: 8),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ).toList(),
            visibleCount: 3,
            stackFrom: StackFrom.Top,
            translationInterval: 6,
            scaleInterval: 0.03,
            onEnd: () => debugPrint("onEnd"),
            onSwipe: (int index, SwiperPosition position) {
              debugPrint("onSwipe $index $position");
              results.removeAt(index);
              print(results.length);
              if (index == 0) {
                print('calling The Provider Bloc');
                bloc.sink.add(index);
              }
            },
            onRewind: (int index, SwiperPosition position) =>
                debugPrint("onRewind $index $position"),
          );
        },
      ),
    );
  }
}
