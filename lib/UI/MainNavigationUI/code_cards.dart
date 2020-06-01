import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';
import 'Bloc/navigation_bloc.dart';
import 'NavBar/mainPageSettingsWrapper.dart';

class CodeCards extends StatefulWidget with NavigationStates {
  final Function onMenuTap;
  const CodeCards({Key key, this.onMenuTap}) : super(key: key);

  @override
  _CodeCardsState createState() => _CodeCardsState();
}

class _CodeCardsState extends State<CodeCards> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double CurrentWidth = constraints.constrainWidth();
        double MaxWidth = MediaQuery.of(context).size.width;
        bool border;
        if (MaxWidth == CurrentWidth) {
          border = false;
        } else {
          border = true;
        }
        return Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: PopBlue.withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 1)
                ],
                borderRadius: border
                    ? BorderRadius.circular(40)
                    : BorderRadius.circular(0),
                color: Grey),
            child: BottomBarAndScaffold(onMenuTap: widget.onMenuTap,border: border,)
        );
      },
    );
  }
}
