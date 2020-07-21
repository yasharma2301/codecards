import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'cardResponseModel.dart';

class CardsProvider with ChangeNotifier {
  List<CardsResults> cardsList = [];
  int count;
  bool loadMore = false;
  String errorMessage;
  String next;
  final String getUrl = 'http://192.168.0.105:8000/cards/list?page=';
  // final String getUrl = 'http://192.168.0.7:8000/cards/list?page=';

  Future<List<CardsResults>> callCards(int page) async {
    String url = getUrl + '$page';
    Response response = await get(url);
    if (response.statusCode == 200) {
      final jsonDecoded = await jsonDecode(response.body);
      var cardResponse = CardsResponse.fromJson(jsonDecoded);
      List<CardsResults> cardResult = cardResponse.results;
      setNext(cardResponse.next);
      // appendToCardList(cardResult);
      return cardResult;
    } else {
      Map<String, dynamic> result = json.decode(response.body);
      try {
        // check here! (didn't check if result fails what's the json response) as in details hai ya error
        setMessage(result['details']);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void removeFromCardList(index) {
    cardsList.removeAt(index);
  }

  int returnCardListLength() {
    return cardsList.length;
  }

  void emptyCardList() {
    cardsList = [];
  }

  void appendToCardList(value) {
    value.forEach((element) {
      cardsList.add(element);
    });
    notifyListeners();
  }

  List<CardsResults> getCardList() {
    return cardsList;
  }

  CardsResults getCardAt(index) {
    return cardsList[index];
  }

  void setNext(value) {
    next = value;
    notifyListeners();
  }

  String getNext() {
    return next;
  }

  void setCount(value) {
    count = value;
    notifyListeners();
  }

  int getCount() {
    return count;
  }

  void setLoadMore(value) {
    loadMore = value;
    notifyListeners();
  }

  bool getLoadMore() {
    return loadMore;
  }

  void setMessage(value) {
    errorMessage = value;
    notifyListeners();
  }

  String getMessage() {
    return errorMessage;
  }
}

class CardsApiCall {
  final String getUrl = 'http://192.168.0.7:8000/cards/list?page=';

  Future<List<CardsResults>> getCards(int page) async {
    String url = getUrl + '$page';
    Response response = await get(url);
    if (response.statusCode == 200) {
      final jsonDecoded = await jsonDecode(response.body);
      var cardResponse = CardsResponse.fromJson(jsonDecoded);
      List<CardsResults> cardResult = cardResponse.results;
      return cardResult;
    } else {
      throw Exception();
    }
  }
}

class CardsBloc {
  final CardsApiCall api = CardsApiCall();
  int pageNumber = 1;
  ReplaySubject<List<CardsResults>> _subject = ReplaySubject();
  final ReplaySubject<int> _controller = ReplaySubject();


  Stream<List<CardsResults>> get stream => _subject.stream;
  Sink<int> get sink => _controller.sink;

  CardsBloc() {
    _subject.addStream(Stream.fromFuture(CardsApiCall().getCards(pageNumber)));
    _controller.listen((value) => loadMore(value));
  }

  Future<void> loadMore([int number]) async {
    if (number == 0) {
      print('called?');
      pageNumber += 1;
      List<CardsResults> list = await api.getCards(pageNumber);
      _subject.sink.add(list);
    }
  }

  void dispose() {
    _controller.close();
    _subject.close();
  }

}

