import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/Shared/FlushBar.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height / 2.8,
      width: _width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
              child: Center(
                child: Text(
                  'Find Your Account',
                  style: TextStyle(
                      color: Grey.withOpacity(0.9),
                      fontSize: 22,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
            Container(
              height: _height / 3.5,
              width: _width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enter the email address linked to your account.",
                    style:
                        TextStyle(color: White.withOpacity(0.5), fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: _width - 125,
                    padding: EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
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
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 16)),
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
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.9),
                        ),
                        child: loading
                            ? Center(
                                child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            White)),
                              )
                            : Center(
                                child: Text(
                                  "Next",
                                  style: TextStyle(color: White, fontSize: 18),
                                ),
                              ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _sendRequest() async {
    FocusScope.of(context).unfocus();

    FlushBar flushBar = FlushBar(context: context);

    String url = 'http://192.168.0.105:8000/reset_password/';
    // String url = 'http://192.168.0.7:8000/reset_password/';
    String email = _emailController.text;

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    if (regex.hasMatch(email)) {
      loading = true;
      var response = await http.post(url, body: {'email': email});
      if (response.statusCode == 200) {
        Navigator.pop(context);
        loading = false;
        flushBar.showSuccessFlushBar(
          json.decode(response.body)['message'],
        );
      } else {
        flushBar.showErrorFlushBar(
          json.decode(response.body)['error'].first,
        );
      }
    } else {
      flushBar.showErrorFlushBar(
        "Please provide a valid email address!",
      );
    }
  }
}
