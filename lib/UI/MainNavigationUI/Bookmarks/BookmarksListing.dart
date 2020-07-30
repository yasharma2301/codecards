import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/UI/MainNavigationUI/CardsLogic/hintDialog.dart';
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
  @override
  Widget build(BuildContext context) {
    BookmarkProvider bookmarkProvider = Provider.of<BookmarkProvider>(context);

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
                items: bookmarkProvider.bookmarks
                    .map(
                      (e) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: BoxDecoration(
                          color: LightGrey.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.lightbulb_outline),
                                    color: Colors.white,
                                    onPressed: () {
                                      _showHintDialog(hint: e.hint);
                                    }),
                                Text(
                                  e.id.toString(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                Text(
                                  e.question,
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
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
