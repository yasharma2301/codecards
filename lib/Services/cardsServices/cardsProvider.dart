import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'cardResponseModel.dart';

class CardsProvider extends ChangeNotifier {
  // Temporary use
  List<CardsResults> cardsList;
  bool loading = false;
  int count;
  String errorMessage;
  String next;
  String previous;
  final String getUrl = 'http://127.0.0.1:8000/cards/list?page=';

  Future<List<CardsResults>> getCards(int page) async {
    String url = getUrl + '$page';
    setLoading(true);
    Response response = await get(url);
    setLoading(false);
    if (response.statusCode == 201) {
      final jsonDecoded = await jsonDecode(response.body);
      var cardResponse = CardsResponse.fromJson(jsonDecoded);
      List<CardsResults> cardResult = cardResponse.results;
      setNext(cardResponse.next);
      setPrevious(cardResponse.previous);
      setCount(cardResponse.count);
      // either this or appendToCardList() method ko use kar sakte hain I guess append wala better hoga
      // abhi to bass future list pass kar rahe
      return cardResult;
    } else {
      print(response.body);
      Map<String, dynamic> result = json.decode(response.body);
      try {
        // check here! (didn't check if result fails what's the json response) as in details hai ya error
        setMessage(result['details']);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void appendToCardList(value){
    value.forEach((element) {cardsList.add(element);});
    notifyListeners();
  }

  void setCardList(value) {
    cardsList = value;
    notifyListeners();
  }

  List<CardsResults> getCardList() {
    return cardsList;
  }

  void setNext(value) {
    next = value;
    notifyListeners();
  }

  String getNext() {
    return next;
  }

  void setPrevious(value) {
    previous = value;
    notifyListeners();
  }

  String getPrevious() {
    return previous;
  }

  void setCount(value) {
    count = value;
    notifyListeners();
  }

  int getCount() {
    return count;
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  void setMessage(value) {
    errorMessage = value;
    notifyListeners();
  }

  String getMessage() {
    return errorMessage;
  }
}
