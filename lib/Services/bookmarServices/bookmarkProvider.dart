import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:codecards/Services/cardsServices/cardResponseModel.dart';

class BookmarkProvider with ChangeNotifier {
  List<CardsResults> bookmarks = List<CardsResults>();
  String userToken;

  BookmarkProvider(String token) {
    userToken = token;
  }

  getBookmarks() async {
    //final String url = 'http://192.168.0.105:8000/bookmarks/';
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
        bookmarks.add(new CardsResults.fromJson(bookmark));
      }
    }
  }
}
