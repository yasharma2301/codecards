import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final Function onMenuTap;

  const MainPage({Key key, this.onMenuTap}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 10),
        child: IconButton(
          splashColor: LightPopBlue.withOpacity(0.8),
          hoverColor: LightPopBlue,
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          ),
          onPressed: widget.onMenuTap,
        ),
      ),
    );
  }
}
