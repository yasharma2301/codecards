import 'dart:async';
import 'package:codecards/Services/ContestsServices/contestNetwork.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/widgets.dart';
import 'contestModel.dart';

class ContestBloc{
  final ContestAPI contestAPI = ContestAPI();
  int pageNumber = 1;
  double pixels = 0.0;
  ReplaySubject<List<ContestsAPIModel>> _subject = ReplaySubject();
  final ReplaySubject<ScrollNotification> _controller = ReplaySubject();

  Stream<List<ContestsAPIModel>> get stream => _subject.stream;
  Sink<ScrollNotification> get sink => _controller.sink;

  ContestBloc() {
    _subject.addStream(Stream.fromFuture(contestAPI.getContests(pageNumber)));
    _controller.listen((notification) => loadPhotos(notification));
  }

  Future<void> loadPhotos([
    ScrollNotification notification,
  ]) async {
    if (notification.metrics.pixels == notification.metrics.maxScrollExtent &&
        pixels != notification.metrics.pixels) {
      pixels = notification.metrics.pixels;
      pageNumber++;
      List<ContestsAPIModel> list = await contestAPI.getContests(pageNumber);
      _subject.sink.add(list);
    }
  }
  void dispose() {
    _controller.close();
    _subject.close();
  }
}