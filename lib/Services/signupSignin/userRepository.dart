import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:codecards/Services/signupSignin/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository with ChangeNotifier {
  UserResponse user;

  bool loading = false;

  String responseMessage;
  int responseCode;

  String userEmail, userName, userToken, userAvatar;

  Future<bool> registerUser(email, username, password, password2) async {
    List avatars = [
      'assets/images/boss.PNG',
      'assets/images/amie.PNG',
      'assets/images/astro.PNG',
      'assets/images/rj.PNG',
      'assets/images/boy.PNG',
      'assets/images/uncle2.PNG',
      'assets/images/jsutin.PNG',
      'assets/images/brenda.PNG',
      'assets/images/nadie.PNG',
      'assets/images/uncle.PNG',
    ];
    avatars.shuffle();

    final String url = 'http://192.168.0.105:8000/register';
    if (email == "" || username == "" || password == "" || password2 == "") {
      setResponse("Please Fill all the fields!", 400);
    } else {
      setLoading(true);
      var body = {
        'email': email,
        'username': username,
        'password': password,
        'password2': password2,
        'avatar': avatars.first
      };

      var result = await http.post(url, body: body);

      Map newUser = json.decode(result.body);
      print(body);
      print(newUser);
      print(result.statusCode);

      if (result.statusCode == 201) {
        setUser(UserResponse.fromJson(newUser));
        print(user.username);
        print(user.token);
        await setResponse(newUser['error_message'], 201);
      } else {
        try {
          await setResponse(newUser['error_message'], result.statusCode);
        } catch (e) {
          print(e);
        }
      }
      setLoading(false);
    }
  }

  Future<void> loginUser(email, password) async {
    final String url = 'http://192.168.0.105:8000/login';

    if (email == "" || password == "") {
      setResponse("Please Fill all the fields!", 400);
    } else {
      setLoading(true);

      var body = {'email': email, 'password': password};

      var result = await http.post(url, body: body);

      Map postResponse = json.decode(result.body);

      if (result.statusCode == 202) {
        setUser(UserResponse.fromJson(postResponse));
        await setResponse(postResponse['error_message'], 202);
      } else {
        try {
          await setResponse(postResponse['error_message'], result.statusCode);
        } catch (e) {
          print(e);
        }
      }
      setLoading(false);
    }
  }

  Future<void> userLogout() async {
    SharedPreferences _sprefs = await SharedPreferences.getInstance();
    _sprefs.remove('userToken');
    _sprefs.remove('userEmail');
    _sprefs.remove('userName');
    _sprefs.remove('userAvatar');
    user = null;
    userEmail = userName = userToken = userAvatar = null;
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  void setUser(value) async {
    SharedPreferences _sprefs = await SharedPreferences.getInstance();
    user = value;

    setUserEmail(user.email, _sprefs);
    setUserName(user.username, _sprefs);
    setUserToken(user.token, _sprefs);
    setUserAvatar(user.avatar, _sprefs);

    notifyListeners();
  }

  UserResponse getUser() {
    return user;
  }

  Future<void> setResponse(message, code) {
    responseMessage = message;
    responseCode = code;
    notifyListeners();
  }

  Map getResponse() {
    return {'responseMessage': responseMessage, 'responseCode': responseCode};
  }

  bool isUser() {
    return user != null ? true : false;
  }

  void setUserEmail(email, _sprefs) async {
    userEmail = email;
    _sprefs.setString('userEmail', userEmail);
  }

  String getUserEmail() {
    return userEmail;
  }

  void setUserName(username, _sprefs) async {
    userName = username;
    _sprefs.setString('userName', userName);
  }

  String getUserName() {
    return userName;
  }

  void setUserToken(token, _sprefs) async {
    userToken = token;
    _sprefs.setString('userToken', userToken);
  }

  String getUserToken() {
    return userToken;
  }

  void setUserAvatar(avatar, _sprefs) async {
    userAvatar = avatar;
    _sprefs.setString('userAvatar', userAvatar);
  }

  String getUserAvatar() {
    return userAvatar;
  }
}
