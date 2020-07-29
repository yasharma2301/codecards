import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';

class HintDialog extends StatefulWidget {
  final String hint;

  const HintDialog({Key key, this.hint}) : super(key: key);

  @override
  _HintDialogState createState() => _HintDialogState();
}

class _HintDialogState extends State<HintDialog> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 350,
      decoration: BoxDecoration(
        color: Grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white24,
                    offset: Offset(0, 0),
                    blurRadius: 10,
                  )
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColorLight
                    ],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.topRight,
                    tileMode: TileMode.repeated),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Hint',
                      style: TextStyle(
                          color: Grey.withOpacity(0.9),
                          fontSize: 30,
                          fontFamily: 'Nunito Black'),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: Grey,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                child: Container(
                  width: size.width,
                  height: 250,
                  decoration: BoxDecoration(
                      color: LightGrey.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      widget.hint,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
