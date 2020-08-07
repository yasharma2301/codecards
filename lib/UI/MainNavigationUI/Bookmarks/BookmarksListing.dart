import 'package:codecards/Services/Themes/lightDarkThemeProvider.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/Shared/delayed_animation.dart';
import 'package:codecards/UI/MainNavigationUI/CardsLogic/TagPillList.dart';
import 'package:codecards/UI/MainNavigationUI/CardsLogic/hintDialog.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:codecards/Services/bookmarServices/bookmarkProvider.dart';

class BookmarksListing extends StatefulWidget {
  BookmarksListing({Key key}) : super(key: key);

  @override
  _BookmarksListingState createState() => _BookmarksListingState();
}

class _BookmarksListingState extends State<BookmarksListing> {
  List bookmarks;

  @override
  Widget build(BuildContext context) {
    BookmarkProvider bookmarkProvider = Provider.of<BookmarkProvider>(context);
    final darkTheme = Provider.of<LightOrDarkTheme>(context);

    return bookmarkProvider.bookmarks == null
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
          )
        : Container(
            child: CarouselSlider(
                items: bookmarkProvider.bookmarks.reversed.map((bookmark) {
                  return Dismissible(
                    key: Key(bookmarkProvider.bookmarks
                        .indexOf(bookmark)
                        .toString()),
                    direction: DismissDirection.vertical,
                    background: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Red.withOpacity(0.45),
                      ),
                      child: Icon(
                        Icons.delete_outline,
                        color: LightGrey.withOpacity(0.2),
                        size: 500,
                      ),
                    ),
                    onDismissed: (direction) async {
                      await bookmarkProvider.deleteBookmark(
                        bookmark['bookmark_id'],
                        bookmark,
                      );

                      Flushbar(
                        backgroundColor: Colors.blueGrey[900],
                        icon: Icon(
                          Icons.error_outline,
                          color: Colors.redAccent,
                        ),
                        leftBarIndicatorColor: Colors.redAccent,
                        message: "Bookmark Deleted!",
                        duration: Duration(seconds: 3),
                        isDismissible: true,
                      )..show(context);
                    },
                    child: Stack(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Text(
                                            'Bookmark: ${bookmarkProvider.bookmarks.indexOf(bookmark) + 1}',
                                            style: TextStyle(
                                              color: darkTheme.getMode() == true
                                                  ? White
                                                  : Grey,
                                              fontSize: 25,
                                              fontFamily: 'Nunito Black',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: TagPillList(
                                            data: bookmark['tags'] ?? '',
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
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
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: SingleChildScrollView(
                                              child: Text(
                                                bookmark['question'],
                                                style: TextStyle(
                                                  color: darkTheme.getMode() ==
                                                          true
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
                                              'This question was asked by ${bookmark['company']}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                height: 0.9,
                                                color:
                                                    darkTheme.getMode() == true
                                                        ? White
                                                        : Grey,
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
                                _showHintDialog(hint: bookmark['hint']);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  // height: MediaQuery.of(context).size.height / 1.25,
                  aspectRatio: 4 / 5,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  reverse: false,
                  enlargeCenterPage: true,
                  onPageChanged: (pageNumber, changeReason) {
                    print({
                      pageNumber,
                      changeReason,
                    });
                  },
                  scrollDirection: Axis.horizontal,
                ))
            // RaisedButton(
            //   child: Text("Print Bookmarks"),
            //   onPressed: () {
            //     print(bookmarkProvider.bookmarks);
            //   },
            // ),
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
