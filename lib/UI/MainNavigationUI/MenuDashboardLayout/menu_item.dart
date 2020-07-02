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
    return InkWell(
        splashColor: Theme.of(context).primaryColorLight,
        highlightColor: Theme.of(context).primaryColorLight.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
        onTap: widget.isCollapsed
            ? null
            : () async {
                if (await Vibration.hasVibrator()) {
                  Vibration.vibrate(duration: 5);
                }
                BlocProvider.of<NavigationBloc>(context).add(widget.navigateTo);
                widget.onMenuItemClicked();
              },
        child: Ink(
          // width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              widget.icon != null
                  ? Icon(widget.icon,
                      color: widget.isSelected == widget.itemNumber
                          ? Theme.of(context).primaryColorLight
                          : Theme.of(context).primaryColor.withOpacity(0.6))
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
                      : Theme.of(context).primaryColor.withOpacity(0.6),
                  fontSize: widget.isSelected == widget.itemNumber ? 27 : 25,
                  fontWeight: widget.isSelected == widget.itemNumber
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
        ));
  }
}
