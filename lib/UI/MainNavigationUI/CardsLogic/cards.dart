import 'package:codecards/Services/conectivityProvider/conectivityService.dart';
import 'package:codecards/Services/signupSignin/userRepository.dart';
import 'package:codecards/UI/MainNavigationUI/CardsLogic/cachedCards.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_stack/swipe_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:codecards/Services/cardsServices/cardResponseModel.dart';
import 'package:codecards/Services/cardsServices/cardsProvider.dart';
import 'package:codecards/Shared/Colors.dart';

final GlobalKey<SwipeStackState> swipeKey = GlobalKey<SwipeStackState>();

class CardsStack extends StatefulWidget {
  final AsyncSnapshot<List<CardsResults>> snapshot;

  const CardsStack({Key key, this.snapshot}) : super(key: key);

  @override
  _CardsStackState createState() => _CardsStackState();
}

class _CardsStackState extends State<CardsStack> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<CardsBloc>(context);
    final _userProvider = Provider.of<UserRepository>(context);
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    return connectionStatus == ConnectivityStatus.Online
        ? Container(
            child: SwipeStack(
              key: swipeKey,
              children: widget.snapshot.data.map(
                (CardsResults cardsResult) {
                  return SwiperItem(
                    builder: (SwiperPosition position, double progress) {
                      return Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: 2,
                                  color: Colors.blueGrey.withOpacity(0.3)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Text(
                                          'Question Card: ${cardsResult.id}',
                                          style: TextStyle(
                                            color: Grey,
                                            fontSize: 25,
                                            fontFamily: 'Nunito Black',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: TagPillList(
                                          data: cardsResult.tags ?? '',
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 10, right: 10),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.56,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Grey.withOpacity(0.9),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: SingleChildScrollView(
                                            child: Center(
                                              child: Text(
                                                cardsResult.question,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      'This question was asked by ${cardsResult.company}',
                                      style: TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
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
                if (position == SwiperPosition.Right) {
                  bloc.addBookmark(
                    widget.snapshot.data[index].id,
                    _userProvider.userToken,
                  );
                }
                if (index == 0) {
                  PageInformation().incrementQuestionDetails(10);
                } else {
                  PageInformation().incrementQuestionDetails(index);
                }
                widget.snapshot.data.removeAt(index);
              },
              onRewind: (int index, SwiperPosition position) {},
            ),
          )
        : CachedCards();
  }
}

class TagPillList extends StatefulWidget {
  final String data;
  final Color color;

  const TagPillList({Key key, this.data, this.color}) : super(key: key);

  @override
  _TagPillListState createState() => _TagPillListState();
}

class _TagPillListState extends State<TagPillList> {
  @override
  Widget build(BuildContext context) {
    if (widget.data != '') {
      var tagArray = widget.data.split(',').toList();
      return Container(
        height: 30,
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.2),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        tagArray[index],
                        style: TextStyle(
                            color: widget.color,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: tagArray.length,
          scrollDirection: Axis.horizontal,
        ),
      );
    } else {
      return Container();
    }
  }
}
