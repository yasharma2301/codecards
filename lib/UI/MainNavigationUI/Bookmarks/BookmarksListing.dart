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
  List bookmarks;

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
                      (bookmark) => Container(
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: BoxDecoration(
                          color: LightGrey.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Material(
                          child: Stack(
                            children: [
                              Center(
                                child: SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10.0,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        IconButton(
                                            icon: Icon(Icons.lightbulb_outline),
                                            color: Colors.white,
                                            onPressed: () {
                                              _showHintDialog(
                                                  hint: bookmark['hint']);
                                            }),
                                        Text(
                                          "Question-${bookmark['id']}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          bookmark['question'],
                                          style: TextStyle(
                                              color: Colors.blue, fontSize: 20),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                splashColor: Red,
                                onTap: () async {
                                  await bookmarkProvider.deleteBookmark(
                                    bookmark['bookmark_id'],
                                    bookmark,
                                  );
                                },
                                onLongPress: () {
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(
                                            Icons.delete_outline,
                                            color: Red,
                                          ),
                                          SizedBox(
                                            width: 15.0,
                                          ),
                                          Text("Delete Bookmark!"),
                                        ],
                                      ),
                                      duration: Duration(
                                        milliseconds: 600,
                                      ),
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(15.0),
                                child: Ink(
                                  padding: EdgeInsets.all(
                                    20,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Icon(
                                    Icons.delete_sweep,
                                    color: Red,
                                    size: 30.0,
                                  ),
                                ),
                                // tooltip: "Delete this Bookmark",
                              ),
                            ],
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
