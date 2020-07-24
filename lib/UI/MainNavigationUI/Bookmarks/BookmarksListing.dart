import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    // bookmarkProvider.getBookmarks("e5ab06a2793d8eb07bcf4fe10d5787921f3e0d95");
    // print(bookmarkProvider.bookmarks);

    return Container(
      child: RaisedButton(
        child: Text("Print Bookmarks"),
        onPressed: () {
          print(bookmarkProvider.bookmarks);
        },
      ),
    );
  }
}
