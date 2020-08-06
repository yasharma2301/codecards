import 'package:codecards/Services/Themes/lightDarkThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:codecards/Shared/Colors.dart';
import 'package:codecards/Shared/FlushBar.dart';
import 'package:codecards/Services/signupSignin/userRepository.dart';

class UserInfo extends StatefulWidget {
  final double width;
  final BuildContext settingsContext;

  UserInfo({
    this.width,
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
    final darkTheme = Provider.of<LightOrDarkTheme>(context);
    final UserRepository _userProvider = Provider.of<UserRepository>(context);
    FlushBar flushBar = FlushBar(context: context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Material(
        elevation: 20,
        child: Container(
          width: widget.width,
          decoration:
              BoxDecoration(color: darkTheme.getMode() == true ?Grey:White, borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: darkTheme.getMode() == true ?LightGrey.withOpacity(0.7):Colors.grey.withOpacity(0.3),
                  ),
                  child: TextFormField(
                    initialValue: _userProvider.getUserName() ?? "hello",
                    readOnly: !_editing,
                    style: TextStyle(
                      color: darkTheme.getMode() == true ?White.withOpacity(0.7):Grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Username",
                      labelStyle: TextStyle(
                        color: darkTheme.getMode() == true ?Theme.of(context).primaryColor.withOpacity(0.8):Theme.of(context).primaryColor,
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

                                    if (editedUsername == "") {
                                      flushBar.showErrorFlushBar(
                                        "Username cannot be blank",
                                      );
                                      return;
                                    }
                                    if (_userProvider.getUserName() !=
                                        editedUsername) {
                                      await _userProvider.setUserName(
                                          editedUsername, null,
                                          update: true);
                                      Map response = _userProvider.getResponse();
                                      if (response['responseCode'] == 202) {
                                        flushBar.showSuccessFlushBar(
                                          response['responseMessage'],
                                        );
                                      } else {
                                        flushBar.showErrorFlushBar(
                                          response['responseMessage'],
                                        );
                                      }
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
      ),
    );
  }
}
