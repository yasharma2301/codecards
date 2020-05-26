import 'package:flutter/material.dart';

class Slide {
  final flare, title, description, animation;

  Slide(
      {@required this.flare,
      @required this.title,
      @required this.description,
      @required this.animation});
}

final SlideList = [
  Slide(
      flare: 'assets/code.flr',
      title: 'Swipe as you Code',
      description:
          'We introduce the all new method of coding.\n Read a question. Write an Algorithm. Get Stuck? Get some hints.',
      animation: 'coding'),
  Slide(
      flare: 'assets/mobile.flr',
      title: 'Bookmark & View Reports',
      description:
          'We introduce the all new method of coding.\n Read a question. Write an Algorithm. Get Stuck? Get some hints.',
      animation: 'check_profile'),
  Slide(
      flare: 'assets/OAuth.flr',
      title: 'We don\'t Store Your Data',
      description:
          'We introduce the all new method of coding.\n Read a question. Write an Algorithm. Get Stuck? Get some hints.',
      animation: 'Untitled'),
];
