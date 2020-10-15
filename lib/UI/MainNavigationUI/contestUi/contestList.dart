import 'package:codecards/Services/ContestsServices/contestBloc.dart';
import 'package:codecards/Services/ContestsServices/contestModel.dart';
import 'package:codecards/UI/MainNavigationUI/contestUi/contestTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContestList extends StatefulWidget {
  @override
  _ContestListState createState() => _ContestListState();
}

class _ContestListState extends State<ContestList> {
  List<ContestsAPIModel> contests;
  List<int> maxContest = [];

  @override
  void initState() {
    super.initState();
    maxContest.addAll(List.generate(100, (x) => x));
    contests = [];
  }

  bool onNotification(ScrollNotification scrollInfo, ContestBloc bloc) {
    if (scrollInfo is OverscrollNotification) {
      bloc.sink.add(scrollInfo);
    }
    return false;
  }

  Widget buildListView(
    BuildContext context,
    AsyncSnapshot<List<ContestsAPIModel>> snapshot,
  ) {
    if (!snapshot.hasData) {
      return Center(child: CircularProgressIndicator());
    }

    contests.addAll(snapshot.data);

    return ListView.builder(
      itemCount: (maxContest.length > contests.length)
          ? contests.length + 1
          : contests.length,
      itemBuilder: (context, index) => (index == contests.length)
          ? Container(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
            )
          : ContestTile(
              contestObject: contests[index],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ContestBloc>(context);
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) => onNotification(notification, bloc),
      child: StreamBuilder<List<ContestsAPIModel>>(
        stream: bloc.stream,
        builder: (context, AsyncSnapshot<List<ContestsAPIModel>> snapshot) {
          return buildListView(context, snapshot);
        },
      ),
    );
  }
}
