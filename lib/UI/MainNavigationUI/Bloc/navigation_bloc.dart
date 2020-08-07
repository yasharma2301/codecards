import 'package:bloc/bloc.dart';
import '../bookmarks.dart';
import '../code_cards.dart';
import '../community.dart';
import '../contributeAQuestion.dart';
import '../leftPanelSettings.dart';

enum NavigationEvents {
  CodeCardsClickEvent,
  BookmarksClickEvent,
  CommunityClickEvent,
  PremiumClickEvent,
  ContributeClickEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  final Function onMenuTap;
  NavigationBloc({this.onMenuTap});

  @override
  NavigationStates get initialState => CodeCards(onMenuTap: onMenuTap);

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.CodeCardsClickEvent:
        yield CodeCards(
          onMenuTap: onMenuTap,
        );
        break;
      case NavigationEvents.BookmarksClickEvent:
        yield BookMarks(onMenuTap: onMenuTap);
        break;
      case NavigationEvents.CommunityClickEvent:
        yield Community(onMenuTap: onMenuTap);
        break;
      case NavigationEvents.PremiumClickEvent:
        yield LeftPanelSettings(onMenuTap: onMenuTap);
        break;
      case NavigationEvents.ContributeClickEvent:
        yield ContributeQuestion(onMenuTap: onMenuTap);
        break;
    }
  }
}
