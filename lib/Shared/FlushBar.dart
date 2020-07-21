import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class FlushBar {
  final BuildContext context;

  FlushBar({this.context});

  Future showErrorFlushBar(String error) {
    Flushbar(
      backgroundColor: Colors.blueGrey[900],
      icon: Icon(
        Icons.error_outline,
        color: Colors.redAccent,
      ),
      leftBarIndicatorColor: Colors.redAccent,
      message: error,
      duration: Duration(seconds: 3),
      isDismissible: true,
    )..show(context);
    return null;
  }

  Future showSuccessFlushBar(String error) {
    Flushbar(
      backgroundColor: Colors.blueGrey[900],
      icon: Icon(
        Icons.check_circle_outline,
        color: Colors.greenAccent,
      ),
      leftBarIndicatorColor: Colors.greenAccent,
      message: error,
      duration: Duration(seconds: 3),
      isDismissible: true,
    )..show(context);
    return null;
  }
}
