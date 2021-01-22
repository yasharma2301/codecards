import 'package:codecards/Services/Themes/lightDarkThemeProvider.dart';
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
import 'TagPillList.dart';

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
    final darkTheme = Provider.of<LightOrDarkTheme>(context);
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
                              color: darkTheme.getMode() == true
                                  ? Color(0xFF2f394b)
                                  : Colors.grey[200],
                              border: Border.all(
                                  width: 2,
                                  color: Colors.blueGrey.withOpacity(0.3)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15,right: 15,bottom: 5),
                                        child: Text(
                                          'Card: ${cardsResult.id}',
                                          style: TextStyle(
                                            color: darkTheme.getMode() == true
                                                ? White
                                                : Grey,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat',
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
                                            top: 5, left: 10, right: 10),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.6,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: darkTheme.getMode() == true
                                                  ? Grey.withOpacity(0.9)
                                                  : White,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Asked by: ${cardsResult.company}',
                                                  style: TextStyle(
                                                      color: Colors.redAccent[200],
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(height: 5,),
                                                Text(
                                                  cardsResult.question,
                                                  style: TextStyle(
                                                      color:
                                                      darkTheme.getMode() ==
                                                          true
                                                          ? White
                                                          : Grey,
                                                      fontSize: 17),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ],
                                            )
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

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
