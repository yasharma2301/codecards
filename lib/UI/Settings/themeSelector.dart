import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';

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
        // mainAxisAlignment: MainAxisAlignment.center,
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
                    padding: EdgeInsets.only(left: 20, right: 60),
                    height: 80,
                    width: width / 2 + 20,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.7),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        topLeft: Radius.circular(8),
                      ),
                      border: _darkTheme
                          ? Border.all(color: White, width: 3)
                          : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.brightness_4,
                          size: 30,
                          color: Grey,
                        ),
                        Text(
                          "DARK THEME",
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
                    padding: EdgeInsets.only(left: 60, right: 20),
                    height: 80,
                    width: width / 2 + 20,
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).primaryColorLight.withOpacity(0.7),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      border: _darkTheme
                          ? null
                          : Border.all(color: White, width: 3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "LIGHT THEME",
                          style: TextStyle(fontSize: 16, color: White),
                        ),
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
    // TODO: implement shouldReclip
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
    // TODO: implement shouldReclip
    return true;
  }
}
