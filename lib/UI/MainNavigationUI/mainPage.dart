import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/UI/Settings/settings2.dart';
import 'package:codecards/routes/slideFromRight.dart';
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
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 30,left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  splashColor: LightPopBlue.withOpacity(0.5),
                  hoverColor: LightPopBlue,
                  highlightColor: Colors.transparent,
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: widget.onMenuTap,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    splashColor: LightPopBlue.withOpacity(0.5),
                    hoverColor: LightPopBlue,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 25,
                    ),
                    onPressed:(){
                      Navigator.push(context,SlideFromRightPageRoute(page: Settings()));
                    }
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
