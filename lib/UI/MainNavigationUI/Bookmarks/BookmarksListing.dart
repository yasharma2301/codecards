import 'package:codecards/Services/conectivityProvider/conectivityService.dart';
import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/UI/MainNavigationUI/Bookmarks/Bookmark.dart';
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
  @override
  Widget build(BuildContext context) {
    BookmarkProvider bookmarkProvider = Provider.of<BookmarkProvider>(context);
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

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
                  return connectionStatus == ConnectivityStatus.Online
                      ? Dismissible(
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
                          child: Bookmark(
                            bookmark: bookmark,
                          ),
                        )
                      : Bookmark(
                          bookmark: bookmark,
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
                )));
  }
}
