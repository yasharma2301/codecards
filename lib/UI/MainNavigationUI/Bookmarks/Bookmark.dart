import 'package:codecards/Services/Themes/lightDarkThemeProvider.dart';
import 'package:codecards/Services/bookmarServices/bookmarkProvider.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/Shared/delayed_animation.dart';
import 'package:codecards/UI/MainNavigationUI/CardsLogic/TagPillList.dart';
import 'package:codecards/UI/MainNavigationUI/CardsLogic/hintDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bookmark extends StatefulWidget {
  final Map bookmark;

  const Bookmark({Key key, this.bookmark}) : super(key: key);

  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  @override
  Widget build(BuildContext context) {
    BookmarkProvider bookmarkProvider = Provider.of<BookmarkProvider>(context);
    final darkTheme = Provider.of<LightOrDarkTheme>(context);

    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: darkTheme.getMode() == true
                ? Color(0xFF2f394b)
                : Colors.grey[200],
            boxShadow: [
              BoxShadow(
                color: darkTheme.getMode() == true
                    ? Colors.grey[200]
                    : Color(0xFF2f394b),
                blurRadius: 7.5,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: SingleChildScrollView(
            child: Material(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      // crossAxisAlignment:
                      //     CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Bookmark: ${bookmarkProvider.bookmarks.indexOf(widget.bookmark) + 1}',
                            style: TextStyle(
                              color: darkTheme.getMode() == true ? White : Grey,
                              fontSize: 25,
                              fontFamily: 'Nunito Black',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TagPillList(
                            data: widget.bookmark['tags'] ?? '',
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 20,
                          ),
                          margin: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                              color: darkTheme.getMode() == true
                                  ? Grey.withOpacity(0.9)
                                  : White,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: SingleChildScrollView(
                              child: Text(
                                widget.bookmark['question'],
                                style: TextStyle(
                                  color: darkTheme.getMode() == true
                                      ? White
                                      : Grey,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 25.0,
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              'This question was asked by ${widget.bookmark['company']}',
                              style: TextStyle(
                                fontSize: 16,
                                height: 0.9,
                                color:
                                    darkTheme.getMode() == true ? White : Grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        DelayedAnimation(
          delay: 1000,
          startOffset: Offset(-0.5, 0),
          child: Container(
            width: 75.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(1000),
                topRight: Radius.circular(1000),
              ),
              color: Colors.amber[800],
            ),
            child: IconButton(
              icon: Icon(
                Icons.lightbulb_outline,
                color: White,
              ),
              onPressed: () {
                _showHintDialog(hint: widget.bookmark['hint']);
              },
            ),
          ),
        ),
      ],
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
