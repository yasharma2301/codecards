import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:codecards/Services/cardsServices/cardResponseModel.dart';

class BookmarkProvider with ChangeNotifier {
  List<Map> bookmarks = List<Map>();
  String userToken;

  BookmarkProvider(String token) {
    userToken = token;
  }

  getBookmarks() async {
    //final String url = 'http://192.168.0.7:8000/bookmarks/';
    final String url = 'http://192.168.0.7:8000/bookmarks/';
    var response = await http.get(
      url,
      headers: {
        'token': userToken,
      },
    );

    if (response.statusCode == 200) {
      List responseBookmarks = json.decode(response.body);
      bookmarks = [];
      for (var bookmark in responseBookmarks) {
        Map bookmarkData = new CardsResults.fromJson(bookmark).toJson();
        bookmarkData['bookmark_id'] = bookmark['bookmark_id'];
        bookmarks.add(bookmarkData);
      }
    }
    notifyListeners();
  }

  Future<List> deleteBookmark(int bookmarkId, var bookmark) async {
    final String url = 'http://192.168.0.7:8000/bookmarks/';
    var response = await http.delete(
      url,
      headers: {
        'id': bookmarkId.toString(),
      },
    );
    if (response.statusCode == 200) {
      bookmarks.remove(bookmark);
    }
    notifyListeners();
    return bookmarks;
  }
}
