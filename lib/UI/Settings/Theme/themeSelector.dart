import 'package:flutter/material.dart';

import 'package:codecards/Shared/Colors.dart';

class ThemeSelector extends StatefulWidget {
  ThemeSelector({Key key}) : super(key: key);

  @override
  _ThemeSelectorState createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends State<ThemeSelector> {
  bool _darkTheme = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 40;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: ClipPath(
              clipper: LeftClipper(),
              child: Material(
                child: InkWell(
                  splashColor: Theme.of(context).primaryColorLight,
                  onTap: () {
                    setState(() {
                      _darkTheme = true;
                    });
                  },
                  child: Ink(
                    padding: EdgeInsets.only(left: 10),
                    height: 80,
                    width: width / 2 + 20,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        topLeft: Radius.circular(8),
                      ),
                      border: _darkTheme
                          ? Border.all(color: White, width: 3)
                          : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.brightness_4,
                          size: 30,
                          color: Grey,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "DARK\nTHEME",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: White),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ClipPath(
              clipper: RightClipper(),
              child: Material(
                child: InkWell(
                  splashColor: Theme.of(context).primaryColor,
                  onTap: () {
                    setState(() {
                      _darkTheme = false;
                    });
                  },
                  child: Ink(
                    padding: EdgeInsets.only(right: 10),
                    height: 80,
                    width: width / 2 + 20,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      border: _darkTheme
                          ? null
                          : Border.all(color: White, width: 3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "LIGHT\nTHEME",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: White),
                        ),
                        SizedBox(width: 20),
                        Icon(
                          Icons.brightness_7,
                          size: 30,
                          color: White,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RightClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(50, 0);

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class LeftClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(0, 0);

    path.lineTo(0, size.height);
    path.lineTo(size.width - 50, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
