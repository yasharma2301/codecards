import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:codecards/Services/cardsServices/cardResponseModel.dart';
import 'package:path_provider/path_provider.dart';

class BookmarkProvider with ChangeNotifier {
  List<Map> bookmarks = List<Map>();
  String userToken;

  BookmarkProvider(String token) {
    userToken = token;
  }

  getBookmarks() async {
    String bookmarksFileName = 'bookmarks.json';
    var dir = await getTemporaryDirectory();
    File bookmarksFile = File(dir.path + '/' + bookmarksFileName);

    //final String url = 'http://192.168.0.105:8000/bookmarks/';
    final String url = 'http://192.168.0.105:8000/bookmarks/';
    var response = await http.get(
      url,
      headers: {
        'token': userToken,
      },
    );

    if (response.statusCode == 200) {
      // print(response.body);
      // List responseBookmarks = json.decode(response.body);
      // bookmarks = [];
      // for (var bookmark in responseBookmarks) {
      //   Map bookmarkData = new CardsResults.fromJson(bookmark).toJson();
      //   bookmarkData['bookmark_id'] = bookmark['bookmark_id'];
      //   bookmarks.add(bookmarkData);
      // }
      // bookmarksFile.writeAsStringSync(bookmarks.toString(),
      //     flush: true, mode: FileMode.write);
      renderBookmarks(response.body, bookmarksFile);
    }
    notifyListeners();
  }

  getBookmarksOffline() async {
    String bookmarksFileName = 'bookmarks.json';
    var dir = await getTemporaryDirectory();
    File bookmarksFile = File(dir.path + '/' + bookmarksFileName);
    var bookmarkDataAsString = bookmarksFile.readAsStringSync();
    renderBookmarks(bookmarkDataAsString, bookmarksFile);
    notifyListeners();
  }

  renderBookmarks(String bookmarksAsString, File bookmarksFile) async {
    List responseBookmarks = json.decode(bookmarksAsString);
    bookmarks = [];
    for (var bookmark in responseBookmarks) {
      Map bookmarkData = new CardsResults.fromJson(bookmark).toJson();
      bookmarkData['bookmark_id'] = bookmark['bookmark_id'];
      bookmarks.add(bookmarkData);
    }
    bookmarksFile.writeAsStringSync(bookmarksAsString,
        flush: true, mode: FileMode.write);
  }

  Future<List> deleteBookmark(int bookmarkId, var bookmark) async {
    final String url = 'http://192.168.0.105:8000/bookmarks/';
    var response = await http.delete(
      url,
      headers: {
        'id': bookmarkId.toString(),
      },
    );
    if (response.statusCode == 200) {
      bookmarks.remove(bookmark);
    }

    await getBookmarks();

    notifyListeners();
    return bookmarks;
  }
}
