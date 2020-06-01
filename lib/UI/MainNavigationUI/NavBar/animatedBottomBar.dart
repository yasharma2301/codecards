import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';

class AnimatedBottomBar extends StatefulWidget {
  final List<BarItem> barItems;
  final Duration animationDuration;
  final bool border;
  final Function onBarTap;

  const AnimatedBottomBar(
      {Key key,
      this.onBarTap,
      this.border,
      this.barItems,
      this.animationDuration = const Duration(milliseconds: 500)})
      : super(key: key);

  @override
  _AnimatedBottomBarState createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar>
    with TickerProviderStateMixin {
  int selectedBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.border
          ? EdgeInsets.symmetric(horizontal: 40)
          : EdgeInsets.symmetric(horizontal: 0),
      child: Container(
          decoration: BoxDecoration(
              color: LightGrey.withOpacity(0.7),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 6, top: 6, left: 5),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _buildBarItems(),
            ),
          )),
    );
  }

  List<Widget> _buildBarItems() {
    List<Widget> _barItems = List();
    for (int i = 0; i < widget.barItems.length; i++) {
      BarItem item = widget.barItems[i];
      bool isSelected = selectedBarIndex == i;
      _barItems.add(InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            selectedBarIndex = i;
            widget.onBarTap(selectedBarIndex);
          });
        },
        child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              color: isSelected
                  ? item.color.withOpacity(0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(30)),
          duration: Duration(milliseconds: 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                item.iconData,
                color: isSelected ? item.color : White.withOpacity(0.7),
              ),
              SizedBox(
                width: 8,
              ),
              AnimatedSize(
                duration: Duration(milliseconds: 100),
                curve: Curves.easeInOut,
                vsync: this,
                child: Text(
                  isSelected ? item.title : "",
                  style: TextStyle(
                      color: item.color,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ));
    }
    return _barItems;
  }
}

class BarItem {
  String title;
  IconData iconData;
  Color color;

  BarItem({this.title, this.iconData, this.color});
}
