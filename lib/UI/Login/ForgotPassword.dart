import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';
import 'dart:convert';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height / 2.8,
      width: _width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Find Your Account",
            style: TextStyle(
                color: White, fontSize: 22, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Enter the email address linked to your account.",
            style: TextStyle(color: White.withOpacity(0.5), fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: _width - 125,
            padding: EdgeInsets.symmetric(horizontal: 18,),
            height: _height / 12.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: LightGrey.withOpacity(0.7),
            ),
            child: Center(
              child: TextFormField(
                controller: _emailController,
                style: TextStyle(
                  color: White.withOpacity(0.7),
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.mail_outline,
                      color: Grey,
                    ),
                    border: InputBorder.none,
                    hintText: "Enter Email",
                    hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.6), fontSize: 16)),
              ),
            ),
          ),
          SizedBox(height: 15),
          InkWell(
              onTap: _sendRequest,
              child: Ink(
                width: _width - 125,
                height: _height / 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.redAccent.withOpacity(0.7),
                ),
                child: Center(
                  child: Text(
                    "Next",
                    style: TextStyle(color: White, fontSize: 18),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  void _sendRequest() async {
    FocusScope.of(context).unfocus();

    String url = 'http://192.168.0.105:8000/reset_password/';
    String email = _emailController.text;

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    if (regex.hasMatch(email)) {
      var response = await http.post(url, body: {'email': email});
      if (response.statusCode == 200) {
        Navigator.pop(context);
        Flushbar(
          icon: Icon(Icons.tag_faces, color: Colors.greenAccent),
          leftBarIndicatorColor: Colors.greenAccent,
          message: json.decode(response.body)['message'],
          duration: Duration(seconds: 3),
          isDismissible: true,
        )..show(context);
      } else
        Flushbar(
          icon: Icon(Icons.error_outline, color: Colors.redAccent),
          leftBarIndicatorColor: Colors.redAccent,
          message: json.decode(response.body)['error'].first,
          duration: Duration(seconds: 3),
          isDismissible: true,
        )..show(context);
    } else {
      Flushbar(
        icon: Icon(Icons.error_outline, color: Colors.redAccent),
        leftBarIndicatorColor: Colors.redAccent,
        message: "Please provide a valid email address!",
        duration: Duration(seconds: 3),
        isDismissible: true,
      )..show(context);
    }
  }
}
