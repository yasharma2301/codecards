import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Reset_Password_Webview extends StatefulWidget {
  Reset_Password_Webview({Key key}) : super(key: key);

  @override
  _Reset_Password_WebviewState createState() => _Reset_Password_WebviewState();
}

WebViewController controllerGlobal;

Future<bool> _exitApp(BuildContext context) async {
  var canGoBack = await controllerGlobal.canGoBack();
  if (await controllerGlobal.canGoBack()) {
    print("onwill goback");
    controllerGlobal.goBack();
  } else {
    Scaffold.of(context).showSnackBar(
      const SnackBar(content: Text("No back history item")),
    );
    return Future.value(false);
  }
}

class _Reset_Password_WebviewState extends State<Reset_Password_Webview> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Reset Password"),
          actions: [
            // NavigationCon
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              dispose();
            },
          ),
        ),
        body: WebView(
          initialUrl: 'http://192.168.0.105:8000/reset_password/',
          // initialUrl: 'https://google.com',
          onWebViewCreated: (WebViewController webViewController) async {
            _controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}
