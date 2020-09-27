import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart';

import 'GithubHttpService.dart';
import 'GithubModels.dart';

const String _clientID = '31eab89267a653f6c74b';
const String _clientSecret = '8c406a75c2d65afa5b38399efcb90b6825a261d1';
const String _redirectUri = 'codecards://callback';

class GithubLogin {
  // ignore: cancel_subscriptions
  StreamSubscription _stream = getLinksStream().listen((String link) {
    _checkDeepLink(link);
  }, cancelOnError: true);

  StreamSubscription get stream => _stream;

  static void _checkDeepLink(String link) {
    if (link != null) {
      String code = link.substring(link.indexOf(RegExp('code=')) + 5);
      print('$code ye le code to');
      loginWithGitHub(code).then((email) {
        print("Logged in as: " + email.toString());
      }).catchError((e) {
        print("Login error: " + e.toString());
      });
    }
  }

  void onClickGitHubLoginButton() async {
    const String url = "https://github.com/login/oauth/authorize" +
        "?client_id=" +
        _clientID +
        "&scope=read:user%20user:email" +
        "&redirect_uri=" +
        _redirectUri;
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      print("Error launching");
    }
  }

  static loginWithGitHub(String code) async {
    final response = await http.post(
      "https://github.com/login/oauth/access_token",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: jsonEncode(GitHubLoginRequest(
        clientId: _clientID,
        clientSecret: _clientSecret,
        code: code,
      )),
    );
    GitHubLoginResponse loginResponse =
        GitHubLoginResponse.fromJson(json.decode(response.body));

    return await GitHubHttpService()
        .getEmails(loginResponse.accessToken.toString());
  }
}
