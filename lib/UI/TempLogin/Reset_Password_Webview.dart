import 'dart:async';
import 'package:codecards/Shared/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final webView = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    webView.close();
  }

  @override
  void dispose() {
    webView.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
        backgroundColor: Grey,
      ),
      url: 'http://192.168.0.105:8000/reset_password',
      withJavascript: true,
      withLocalStorage: true,
      withZoom: true,
    );
  }
}
