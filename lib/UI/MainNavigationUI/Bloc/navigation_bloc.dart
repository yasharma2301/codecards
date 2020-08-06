import 'package:bloc/bloc.dart';
import '../bookmarks.dart';
import '../code_cards.dart';
import '../community.dart';
import '../contributeAQuestion.dart';
import '../rate_us.dart';

enum NavigationEvents {
  CodeCardsClickEvent,
  BookmarksClickEvent,
  CommunityClickEvent,
  RateUsClickEvent,
  DeveloperStoryClickEvent,
  // SettingsClickEvent
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
      case NavigationEvents.RateUsClickEvent:
        yield RateUs(onMenuTap: onMenuTap);
        break;
      case NavigationEvents.DeveloperStoryClickEvent:
        yield ContributeQuestion(onMenuTap: onMenuTap);
        break;
      // case NavigationEvents.SettingsClickEvent:
      //   yield Settings();
      //   break;
    }
  }
}
