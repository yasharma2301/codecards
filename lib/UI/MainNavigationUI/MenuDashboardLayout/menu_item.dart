import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codecards/UI/MainNavigationUI/Bloc/navigation_bloc.dart';

class Menuitem extends StatefulWidget {
  final Function onMenuItemClicked;
  final int isSelected;
  final bool isCollapsed;
  final String title;
  final int itemNumber;
  final NavigationEvents navigateTo;
  final IconData icon;

  const Menuitem(
      {Key key,
      this.navigateTo,
      this.itemNumber,
      this.title,
      this.onMenuItemClicked,
      this.isSelected,
      this.isCollapsed,
      this.icon})
      : super(key: key);

  @override
  _MenuitemState createState() => _MenuitemState();
}

class _MenuitemState extends State<Menuitem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.isCollapsed
            ? null
            : () async {
                if (await Vibration.hasVibrator()) {
                  Vibration.vibrate(duration: 5);
                }
                BlocProvider.of<NavigationBloc>(context).add(widget.navigateTo);
                widget.onMenuItemClicked();
              },
        child: Container(
          height: 40,
          child: Row(
            children: [
              widget.icon != null
                  ? Icon(widget.icon,
                      color: widget.isSelected == widget.itemNumber
                          ? Theme.of(context).primaryColorLight
                          : White.withOpacity(0.8))
                  : Container(),
              widget.icon != null
                  ? SizedBox(
                      width: 10,
                    )
                  : Container(),
              Text(
                widget.title,
                style: TextStyle(
                  color: widget.isSelected == widget.itemNumber
                      ? Theme.of(context).primaryColorLight
                      : White.withOpacity(0.8),
                  fontSize: widget.isSelected == widget.itemNumber ? 22 : 19,
                  fontWeight: widget.isSelected == widget.itemNumber
                      ? FontWeight.w700
                      : FontWeight.w300,
                ),
              ),
            ],
          ),
        ));
  }
}
