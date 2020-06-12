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
      padding: const EdgeInsets.symmetric(vertical: 20),
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
                // initialValue: "User69",
                style: TextStyle(
                  color: Orange,
                  fontSize: 25,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: White.withOpacity(0.7),
                    size: 30,
                  ),
                  labelText: "USERNAME",
                  labelStyle: TextStyle(
                    color: White,
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
                    colors: [PopBlue, Colors.blueAccent[100]],
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
                    fontSize: 17,
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
