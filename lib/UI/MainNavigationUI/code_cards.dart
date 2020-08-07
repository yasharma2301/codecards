import 'package:codecards/Services/AdProvider/adProvider.dart';
import 'package:codecards/Services/Themes/lightDarkThemeProvider.dart';
import 'package:codecards/Services/cardsServices/cardResponseModel.dart';
import 'package:codecards/Services/cardsServices/cardsProvider.dart';
import 'package:codecards/Services/conectivityProvider/conectivityService.dart';
import 'package:codecards/Services/notesServices/noteAPIService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:codecards/routes/slideFromRight.dart';
import 'package:codecards/Services/notesServices/noteData.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/UI/Settings/settings2.dart';
import 'package:share/share.dart';
import 'Bloc/navigation_bloc.dart';
import 'CardsLogic/cards.dart';
import 'CardsLogic/hintDialog.dart';
import 'Notes/noteTile.dart';
import 'Notes/noteView.dart';

class CodeCards extends StatefulWidget with NavigationStates {
  final Function onMenuTap;

  const CodeCards({Key key, this.onMenuTap}) : super(key: key);

  @override
  _CodeCardsState createState() => _CodeCardsState();
}

class _CodeCardsState extends State<CodeCards> {
  NoteAPIServerClass noteAPIServerClass = NoteAPIServerClass();

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    final darkTheme = Provider.of<LightOrDarkTheme>(context);
    final bloc = Provider.of<CardsBloc>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final HintCounter hintProvider = Provider.of<HintCounter>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        double currentWidth = constraints.constrainWidth();
        double maxWidth = MediaQuery.of(context).size.width;
        bool border;
        if (maxWidth == currentWidth) {
          border = false;
        } else {
          border = true;
        }
        return Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: PopBlue.withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 1)
              ],
              borderRadius:
                  border ? BorderRadius.circular(30) : BorderRadius.circular(0),
              color: darkTheme.getMode() == true ? Grey : White),
          child: ClipRRect(
            borderRadius:
            border ? BorderRadius.circular(30) : BorderRadius.circular(0),
            child: Stack(
              overflow: Overflow.clip,
              children: [
                Positioned(
                  left: -(height / 2 - width / 2),
                  top: -height * 0.13,
                  child: Container(
                    height: height,
                    width: height,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: darkTheme.getMode() == true
                            ? LightGrey.withOpacity(0.15)
                            : Colors.grey.withOpacity(0.3)),
                  ),
                ),
                Positioned(
                  left: width * 0.15,
                  top: -width * 0.5,
                  child: Container(
                    height: width * 1.6,
                    width: width * 1.6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: darkTheme.getMode() == true
                          ? LightGrey.withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                    ),
                  ),
                ),
                Positioned(
                  right: -width * 0.2,
                  top: -50,
                  child: Container(
                    height: width * 0.6,
                    width: width * 0.6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: darkTheme.getMode() == true
                          ? LightGrey.withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: border == true
                        ? EdgeInsets.only(top: 20)
                        : EdgeInsets.only(top: 30),
                    child: Scaffold(
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: border == true
                                    ? EdgeInsets.only(left: 25)
                                    : EdgeInsets.only(left: 15),
                                child: GestureDetector(
                                  onTap: widget.onMenuTap,
                                  child: Icon(
                                    Icons.menu,
                                    color: darkTheme.getMode() == true
                                        ? Colors.white
                                        : Grey,
                                    size: 30,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'CodeCards',
                                  style: TextStyle(
                                      color:
                                          darkTheme.getMode() == true ? White : Grey,
                                      fontSize: 23,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: IconButton(
                                    splashColor: LightPopBlue.withOpacity(0.5),
                                    hoverColor: LightPopBlue,
                                    highlightColor: Colors.transparent,
                                    icon: Icon(
                                      Icons.settings,
                                      color: darkTheme.getMode() == true
                                          ? Colors.white
                                          : Grey,
                                      size: 25,
                                    ),
                                    onPressed: () {
                                      Navigator.push(context,
                                          SlideFromRightPageRoute(page: Settings()));
                                    }),
                              )
                            ],
                          ),
                          Expanded(
                            child: StreamBuilder<List<CardsResults>>(
                                stream: bloc.stream,
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<CardsResults>> snapshot) {
                                  if (!snapshot.hasData ||
                                      connectionStatus ==
                                          ConnectivityStatus.Offline) {
                                    return Container(
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 15),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                children: border == false
                                                    ? [
                                                        RoundIconButton.small(
                                                          icon: Icons.clear,
                                                          iconSize: 22,
                                                          onPressed: () {},
                                                        ),
                                                        RoundIconButton.large(
                                                          iconSize: 26,
                                                          icon:
                                                              Icons.lightbulb_outline,
                                                          onPressed: () {},
                                                        ),
                                                        RoundIconButton.large(
                                                          iconSize: 28,
                                                          icon: Icons.add,
                                                          onPressed: () {
                                                            _bringUpNotesSheet(
                                                                context, darkTheme);
                                                          },
                                                        ),
                                                        RoundIconButton.large(
                                                          iconSize: 26,
                                                          icon: Icons.bookmark_border,
                                                          onPressed: () {},
                                                        ),
                                                        RoundIconButton.small(
                                                          icon: Icons.share,
                                                          iconSize: 22,
                                                          onPressed: () {},
                                                        ),
                                                      ]
                                                    : [
                                                        RoundIconButton.small(
                                                          icon: Icons.clear,
                                                          iconSize: 22,
                                                          onPressed: () {},
                                                        ),
                                                        RoundIconButton.large(
                                                          iconSize: 26,
                                                          icon:
                                                              Icons.lightbulb_outline,
                                                          onPressed: () {},
                                                        ),
                                                        RoundIconButton.large(
                                                          iconSize: 28,
                                                          icon: Icons.add,
                                                          onPressed: () {
                                                            _bringUpNotesSheet(
                                                                context, darkTheme);
                                                          },
                                                        ),
                                                        RoundIconButton.large(
                                                          iconSize: 26,
                                                          icon: Icons.bookmark_border,
                                                          onPressed: () {},
                                                        ),
                                                      ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            child: Container(
                                              height:
                                                  MediaQuery.of(context).size.height *
                                                      0.75,
                                              width:
                                                  MediaQuery.of(context).size.width,
                                              child: Center(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: LightGrey, width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(8)),
                                                  child: Center(
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return Container(
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: 0),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 13, vertical: 15),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                children: border == false
                                                    ? [
                                                        RoundIconButton.small(
                                                          icon: Icons.clear,
                                                          iconSize: 22,
                                                          onPressed: () {
                                                            swipeKey.currentState
                                                                .swipeLeft();
                                                          },
                                                        ),
                                                        RoundIconButton.large(
                                                          iconSize: 26,
                                                          icon:
                                                              Icons.lightbulb_outline,
                                                          onPressed: () {
                                                            _showHintDialog(
                                                                context: context,
                                                                hint: snapshot
                                                                    .data[swipeKey
                                                                        .currentState
                                                                        .currentIndex]
                                                                    .hint,
                                                                hintCounter:
                                                                    hintProvider);
                                                          },
                                                        ),
                                                        RoundIconButton.large(
                                                          iconSize: 28,
                                                          icon: Icons.add,
                                                          onPressed: () {
                                                            _bringUpNotesSheet(
                                                                context, darkTheme);
                                                          },
                                                        ),
                                                        RoundIconButton.large(
                                                          iconSize: 26,
                                                          icon: Icons.bookmark_border,
                                                          onPressed: () {
                                                            swipeKey.currentState
                                                                .swipeRight();
                                                          },
                                                        ),
                                                        RoundIconButton.small(
                                                          icon: Icons.share,
                                                          iconSize: 22,
                                                          onPressed: () {
                                                            share(
                                                                context,
                                                                snapshot.data[swipeKey
                                                                    .currentState
                                                                    .currentIndex]);
                                                          },
                                                        ),
                                                      ]
                                                    : [
                                                        RoundIconButton.small(
                                                          icon: Icons.clear,
                                                          iconSize: 22,
                                                          onPressed: () {
                                                            swipeKey.currentState
                                                                .swipeLeft();
                                                          },
                                                        ),
                                                        RoundIconButton.large(
                                                          iconSize: 26,
                                                          icon:
                                                              Icons.lightbulb_outline,
                                                          onPressed: () {
                                                            _showHintDialog(
                                                                context: context,
                                                                hint: snapshot
                                                                    .data[swipeKey
                                                                        .currentState
                                                                        .currentIndex]
                                                                    .hint,
                                                                hintCounter:
                                                                    hintProvider);
                                                          },
                                                        ),
                                                        RoundIconButton.large(
                                                          iconSize: 28,
                                                          icon: Icons.add,
                                                          onPressed: () {
                                                            _bringUpNotesSheet(
                                                                context, darkTheme);
                                                          },
                                                        ),
                                                        RoundIconButton.large(
                                                          iconSize: 26,
                                                          icon: Icons.bookmark_border,
                                                          onPressed: () {
                                                            swipeKey.currentState
                                                                .swipeRight();
                                                          },
                                                        ),
                                                      ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        IgnorePointer(
                                          ignoring: border == true ? true : false,
                                          child: Container(
                                            height:
                                                MediaQuery.of(context).size.height *
                                                    0.8,
                                            padding:
                                                EdgeInsets.only(bottom: 0, top: 10),
                                            child: CardsStack(
                                              snapshot: snapshot,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void share(BuildContext context, CardsResults cardsResults) {
    final RenderBox box = context.findRenderObject();
    Share.share(
        "Here is a question for you,\n\n${cardsResults.question}\n\nCan you help me solving this?\nDownload the CodeCards app today :{Play store link here}",
        subject: 'CodeCards Question ${cardsResults.id}',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  void _showHintDialog(
      {String hint, BuildContext context, HintCounter hintCounter}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        hintCounter.decreaseHints();
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.transparent,
          child: HintDialog(
            hintCount: hintCounter.getHint(),
            hint: hint,
          ),
        );
      },
    );
  }

  void _bringUpNotesSheet(BuildContext context, var darkTheme) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStatee) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                  color: darkTheme.getMode() == true ? Grey : White,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15))),
              child: Scaffold(
                floatingActionButton: FloatingActionButton(
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColorLight
                          ],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.topRight,
                          tileMode: TileMode.repeated),
                    ),
                    child: Icon(
                      Icons.add,
                      color: White,
                      size: 30,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NoteView(
                          noteMode: NoteModes.Adding,
                        ),
                      ),
                    );
                  },
                ),
                body: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white24,
                            offset: Offset(0, 0),
                            blurRadius: 10,
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        gradient: LinearGradient(
                            colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColorLight
                            ],
                            begin: FractionalOffset.topLeft,
                            end: FractionalOffset.topRight,
                            tileMode: TileMode.repeated),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Notes',
                              style: TextStyle(
                                  color: Grey.withOpacity(0.9),
                                  fontSize: 30,
                                  fontFamily: 'Nunito Black'),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.star_border,
                                  color: Grey,
                                  size: 30,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 70),
                            child: FutureBuilder(
                              future:
                                  Provider.of<NoteData>(context).getNoteList(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return NoteTile(titleIndex: index);
                                    },
                                    itemCount: Provider.of<NoteData>(context)
                                        .noteCount,
                                  );
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                  ));
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final double iconSize;
  final VoidCallback onPressed;

  RoundIconButton.large({this.icon, this.onPressed, this.iconSize})
      : size = 62.0;

  RoundIconButton.small({this.icon, this.onPressed, this.iconSize})
      : size = 50.0;

  RoundIconButton({
    this.icon,
    this.iconSize,
    this.size,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final darkTheme = Provider.of<LightOrDarkTheme>(context);
    return Container(
      width: size,
      height: size,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColorLight
              ],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              tileMode: TileMode.repeated),
          boxShadow: [
            BoxShadow(
                color:
                    darkTheme.getMode() == true ? Colors.white12 : Colors.grey,
                blurRadius: 7.0),
          ]),
      child: RawMaterialButton(
        shape: CircleBorder(),
        elevation: 0.0,
        child: Icon(
          icon,
          size: iconSize,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
