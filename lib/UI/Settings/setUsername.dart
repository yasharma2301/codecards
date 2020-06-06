import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';

import 'nameDialogBox.dart';

class SetUsername extends StatelessWidget {
  final double width,height;

  const SetUsername({Key key, this.width,this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
      child: GestureDetector(
        onTap: (){showDialog(
            context: context,
            builder: (BuildContext context) {
              return NameDialogBox(
                height: height,
                width: width,
              );
            });
        },
        child: Container(
            height: 80,
            width: width,
            decoration: BoxDecoration(
                color: Grey, borderRadius: BorderRadius.circular(8)),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColorLight],
                            stops: [0.3, 0.95],
                            begin: FractionalOffset.topLeft,
                            end: FractionalOffset.topRight,
                            tileMode: TileMode.repeated),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(50),
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    height: 80,
                    width: width - 255,
                    child: Center(
                      child: Text(
                        'SET A\nUSERNAME',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 30,
                  right: 180,
                  child: Text(
                    'Lucifer Morningstar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
