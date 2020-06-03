import 'package:flutter/material.dart';
import 'package:codecards/UI/Login/SocialButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:codecards/Shared/Colors.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 200,
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: LightGrey),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              width: 350,
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Grey),
              child: TextFormField(
                initialValue: "Coder69",
                style: TextStyle(color: Colors.orange, fontSize: 30),
                cursorColor: Colors.orange,
                decoration: InputDecoration(
                    labelText: "USERNAME",
                    labelStyle:
                        TextStyle(color: White, fontSize: 20, height: 1),
                    border: InputBorder.none),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 350,
            child: SocialButton(
              title: "Logged in with Facebook",
              button: true,
              icon: Icon(FontAwesomeIcons.facebook, color: White,),
              color: Colors.blue[300],
              loggedIn: true,
            ),
          )
        ],
      ),
    );
  }
}
