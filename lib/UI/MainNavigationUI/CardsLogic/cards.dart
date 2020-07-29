import 'package:codecards/Services/signupSignin/userRepository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_stack/swipe_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:codecards/Services/cardsServices/cardResponseModel.dart';
import 'package:codecards/Services/cardsServices/cardsProvider.dart';
import 'package:codecards/Shared/Colors.dart';
import 'hintDialog.dart';

class CardsStack extends StatefulWidget {
  @override
  _CardsStackState createState() => _CardsStackState();
}

class _CardsStackState extends State<CardsStack> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<CardsBloc>(context);
    final _userProvider = Provider.of<UserRepository>(context);

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
          return SwipeStack(
            children: snapshot.data.map(
              (CardsResults cardsResult) {
                return SwiperItem(
                  builder: (SwiperPosition position, double progress) {
                    return Material(
                      elevation: 4,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: LightGrey,
                          border: Border.all(width: 1, color: Grey),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.lightbulb_outline),
                                    color: Colors.white,
                                    onPressed: () {
                                      _showHintDialog(hint: cardsResult.hint);
                                    }),
                                Text(
                                  cardsResult.id.toString(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                Text(
                                  cardsResult.question,
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
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
            onEnd: () {
              PageInformation().incrementQuestionDetails(10);
              bloc.sink.add(0);
            },
            onSwipe: (int index, SwiperPosition position) {
              debugPrint("onSwipe $index $position");
              if (position == SwiperPosition.Right) {
                bloc.addBookmark(
                  snapshot.data[index].id,
                  _userProvider.userToken,
                );
              }
              PageInformation().incrementQuestionDetails(index);
              snapshot.data.removeAt(index);
              print(snapshot.data.length);
            },
            onRewind: (int index, SwiperPosition position) =>
                debugPrint("onRewind $index $position"),
          );
        },
      ),
    );
  }

  void _showHintDialog({String hint}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.transparent,
            child: HintDialog(
              hint: hint,
            ),
          );
        });
  }
}
