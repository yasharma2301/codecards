import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'GithubModels.dart';

class GitHubHttpService {
  Future<String> getEmails(String myFuckingAccessToken) async {
    final String postURL =
        "https://api.github.com/user/emails?access_token=$myFuckingAccessToken";
    Response res = await http.Client().get(postURL);
    String email;
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<GithubModel> git =
          body.map((dynamic item) => GithubModel.fromJson(item)).toList();
      git.forEach((element) {
        if (element.primary == true) {
          email = (element.email);
        }
      });
      return email;
    } else {
      throw Exception();
    }
  }
}
