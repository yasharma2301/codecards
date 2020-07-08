import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:codecards/Services/signupSignin/userModel.dart';
import 'package:flutter/cupertino.dart';

class UserRepository with ChangeNotifier {
  UserResponse user;
  String errorMessage;
  bool loading = false;

  Future<bool> registerUser(email, username, password, password2) async {
    final String url = 'http://192.168.0.7:8000/register';
    if (email != null ||
        username != null ||
        password != null ||
        password2 != null) {
      setLoading(true);
    }
    var body = {
      'email': email,
      'username': username,
      'password': password,
      'password2': password2
    };
    body.addAll({'avatar': ""});

    var result = await http.post(url, body: body);
    var response = jsonDecode(result.body);
    if (result.statusCode == 201) {
      setLoading(false);
      setUser(UserResponse.fromJson(json.decode(result.body)));
      print(user.username);
      print(user.token);
    } else {
      try {
        setMessage(response["password"]);
      } catch (e) {
        print(e);
      }
    }
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  void setUser(value) {
    user = value;
    notifyListeners();
  }

  UserResponse getUser() {
    return user;
  }

  void setMessage(value) {
    errorMessage = value;
    notifyListeners();
  }

  String getMessage() {
    return errorMessage;
  }

  bool isUser() {
    return user != null ? true : false;
  }
}
