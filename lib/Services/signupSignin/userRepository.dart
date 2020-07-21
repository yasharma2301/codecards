import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:codecards/Services/signupSignin/userModel.dart';

class UserRepository with ChangeNotifier {
  UserResponse user;

  bool loading = false;

  String responseMessage;
  int responseCode;

  String userEmail, userName, userToken, userAvatar;

  UserRepository(
      {this.userEmail, this.userName, this.userToken, this.userAvatar}) {
    setUser(UserResponse.fromJson({
      'email': this.userEmail,
      'username': this.userName,
      'avatar': this.userAvatar,
      'token': this.userToken
    }));
  }

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
    // final String url = 'http://192.168.0.7:8000/register';
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

      if (result.statusCode == 201) {
        setUser(UserResponse.fromJson(newUser));
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
    setLoading(false);
    return (isUser());
  }

  Future<bool> loginUser(email, password) async {
    // final String url = 'http://192.168.0.7:8000/login';
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
    setLoading(false);
    return isUser();
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
    return null;
  }

  Map getResponse() {
    return {'responseMessage': responseMessage, 'responseCode': responseCode};
  }

  bool isUser() {
    return user == null ? false : user.token == null ? false : true;
  }

  void setUserEmail(email, _sprefs) async {
    userEmail = email;
    _sprefs.setString('userEmail', userEmail);
    notifyListeners();
  }

  String getUserEmail() {
    return userEmail;
  }

  Future<void> setUserName(username, _sprefs, {update = false}) async {
    if (update) {
      SharedPreferences _sprefs = await SharedPreferences.getInstance();

      setLoading(true);

      final String url = 'http://192.168.0.105:8000/update-account/';
      var response = await http.put(url, body: {
        'username': username,
        'token': userToken,
      });
      Map responseBody = json.decode(response.body);
      if (response.statusCode == 202) {
        await setResponse(responseBody['message'], 202);
        userName = username;
        _sprefs.setString('userName', userName);
      } else {
        await setResponse(responseBody['error_message'], response.statusCode);
      }

      setLoading(false);
    } else {
      userName = username;
      _sprefs.setString('userName', userName);
    }

    notifyListeners();
  }

  String getUserName() {
    return userName;
  }

  void setUserToken(token, _sprefs) async {
    userToken = token;
    _sprefs.setString('userToken', userToken);
    notifyListeners();
  }

  String getUserToken() {
    return userToken;
  }

  void setUserAvatar(avatar, _sprefs, {update = false}) async {
    if (update) {
      SharedPreferences _sprefs = await SharedPreferences.getInstance();

      setLoading(true);

      final String url = 'http://192.168.0.105:8000/update-account/';
      var response = await http.put(url, body: {
        'avatar': avatar,
        'token': userToken,
      });
      Map responseBody = json.decode(response.body);
      if (response.statusCode == 202) {
        await setResponse(responseBody['message'], 202);
        userAvatar = avatar;
        _sprefs.setString('userAvatar', userAvatar);
      } else {
        await setResponse(responseBody['error_message'], response.statusCode);
      }

      setLoading(false);
    } else {
      userAvatar = avatar;
      _sprefs.setString('userAvatar', userAvatar);
    }

    notifyListeners();
  }

  String getUserAvatar() {
    return userAvatar;
  }
}
