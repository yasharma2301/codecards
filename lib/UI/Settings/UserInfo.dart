import 'package:flutter/material.dart';
import 'package:codecards/Shared/Colors.dart';

class UserInfo extends StatefulWidget {
  final double width;

  UserInfo({this.width});

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
      child: Container(
        width: widget.width,
        decoration:
            BoxDecoration(color: Grey, borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
              child: TextFormField(
                style: TextStyle(
                  color: White.withOpacity(0.9),
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  labelText: "USERNAME",
                  labelStyle: TextStyle(
                    color: White.withOpacity(0.5),
                    fontSize: 15
                  ),
                  fillColor: LightGrey.withOpacity(0.6),
                  filled: true,
                  // enabledBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.all(Radius.circular(5)),
                  //   borderSide: BorderSide(color: Colors.transparent),
                  // ),
                  // focusedBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.all(Radius.circular(5)),
                  //   borderSide: BorderSide(color: Colors.transparent),
                  // ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: widget.width,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                gradient: LinearGradient(
                    colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColorLight],
                    stops: [0.1, 0.99],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.topRight,
                    tileMode: TileMode.repeated),
              ),
              child: Center(
                child: Text(
                  'SIGNED IN WITH GOOGLE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
