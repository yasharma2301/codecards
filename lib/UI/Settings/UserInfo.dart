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
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: LightGrey.withOpacity(0.7),
                    ),
                child: TextField(
                  style: TextStyle(
                    color: White.withOpacity(0.7),
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Username",
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6),fontSize: 16)),
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
