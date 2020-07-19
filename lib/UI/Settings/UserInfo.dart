import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flushbar/flushbar.dart';

import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/Services/signupSignin/userRepository.dart';

class UserInfo extends StatefulWidget {
  final double width;
  final String username;
  final BuildContext settingsContext;

  UserInfo({
    this.width,
    this.username,
    this.settingsContext,
  });

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  bool _editing = false;
  String editedUsername = "";

  @override
  Widget build(BuildContext context) {
    final UserRepository _userProvider = Provider.of<UserRepository>(context);
    // setState(() {
    //   editedUsername = _userProvider.getUserName();
    // });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                padding: EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: LightGrey.withOpacity(0.7),
                ),
                child: TextFormField(
                  initialValue: widget.username ?? "hello",
                  // controller: _usernameController,
                  readOnly: !_editing,
                  style: TextStyle(
                    color: White.withOpacity(0.7),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Username",
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor.withOpacity(0.8),
                      fontSize: 18,
                    ),
                    suffixIcon: _userProvider.isLoading()
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor,
                            ),
                          )
                        : _editing
                            ? IconButton(
                                icon: Icon(
                                  Icons.check,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: () async {
                                  setState(() {
                                    _editing = false;
                                  });

                                  if (_userProvider.getUserName() !=
                                          editedUsername &&
                                      editedUsername != "") {
                                    _userProvider.setUserName(
                                        editedUsername, null);

                                    Map response = _userProvider.getResponse();
                                    Flushbar(
                                      icon: response['responseCode'] == 202
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.greenAccent,
                                            )
                                          : Icon(
                                              Icons.error_outline,
                                              color: Colors.redAccent,
                                            ),
                                      leftBarIndicatorColor:
                                          response['responseCode'] == 202
                                              ? Colors.greenAccent
                                              : Colors.redAccent,
                                      message: response['responseMessage'],
                                      duration: Duration(seconds: 1),
                                      isDismissible: true,
                                    )..show(widget.settingsContext)
                                          .whenComplete(() {
                                        _userProvider.setLoading(false);
                                      });
                                  }
                                },
                              )
                            : IconButton(
                                icon: Icon(
                                  Icons.mode_edit,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _editing = true;
                                  });
                                },
                              ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      editedUsername = value;
                    });
                  },
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
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColorLight
                    ],
                    stops: [
                      0.1,
                      0.99
                    ],
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
