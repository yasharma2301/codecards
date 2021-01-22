import 'package:flutter/material.dart';

class Slide {
  final String image, title, description;

  Slide(
      {@required this.image, @required this.title, @required this.description});
}

final SlideList = [
  Slide(
      image: 'assets/image.png',
      title: 'User Friendly',
      description:
      'We provide our users with a friendly and easy to understand interface!'),
  Slide(
      image: 'assets/image.png',
      title: 'Hand Crafted',
      description:
      'The app is bundled with custom curated hints and other features.'),
  Slide(
      image: 'assets/image.png',
      title: 'Contests',
      description:
      'Get notified for various contests from popular sites.'),
];
