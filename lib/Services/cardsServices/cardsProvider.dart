import 'dart:async';
import 'dart:convert';
import 'package:codecards/Services/signupSignin/userRepository.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'cardResponseModel.dart';

class CardsApiCall {
  //final String getUrl = 'http://192.168.0.7:8000/cards/list?page=';
  final String getUrl = 'http://192.168.0.7:8000/cards/list?page=';

  Future<List<CardsResults>> getCards(int page, int start, int end) async {
    String url = getUrl + '$page';
    Response response = await get(url);
    if (response.statusCode == 200) {
      final jsonDecoded = await jsonDecode(response.body);
      var cardResponse = CardsResponse.fromJson(jsonDecoded);
      List<CardsResults> cardResult = cardResponse.results;
      print({
        'start': start,
        'end': end,
      });
      print(
          'fetched only ${cardResult.sublist(start, end).length} number of results');
      List<CardsResults> revResults = cardResult.reversed.toList();
      return revResults.sublist(start, end);
    } else {
      throw Exception('Some error occurred. Could\'nt get cards.');
    }
  }
}

class CardsBloc {
  final CardsApiCall api = CardsApiCall();
  PageInformation pageDetails = PageInformation();

  ReplaySubject<List<CardsResults>> _subject = ReplaySubject();
  final ReplaySubject<int> _controller = ReplaySubject();

  Stream<List<CardsResults>> get stream => _subject.stream;

  Sink<int> get sink => _controller.sink;

  CardsBloc() {
    pageDetails.getPageDetails().then((value) {
      _subject.addStream(Stream.fromFuture(CardsApiCall()
          .getCards(value['page_offset'], 0, value['question_offset'])));
      _controller.listen((value) => loadMore(value));
    });
  }

  Future<void> loadMore([int number]) async {
    if (number == 0) {
      pageDetails.getPageDetails().then((p) {
        pageDetails.incrementPageDetails(p['page_offset']).then((v) async {
          List<CardsResults> list = await api.getCards(v, 0, 10);
          _subject.sink.add(list);
        });
      });
    }
  }

  void dispose() {
    _controller.close();
    _subject.close();
  }

  Future<void> addBookmark(int cardID, String userToken) async {
    print([cardID, userToken]);
    //final String bookmarkURL = 'http://192.168.0.7:8000/bookmarks/';
    final String bookmarkURL = 'http://192.168.0.7:8000/bookmarks/';
    var body = {
      'cardID': cardID.toString(),
      'userToken': userToken,
    };
    var response = await post(
      bookmarkURL,
      body: body,
    );
    print(response.body);
  }
}
