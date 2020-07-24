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

  String userEmail, userName, userToken, userAvatar, pageOffset, questionOffset;

  UserRepository(
      {this.userEmail, this.userName, this.userToken, this.userAvatar}) {
    setUser(
      UserResponse.fromJson(
        {
          'email': this.userEmail,
          'username': this.userName,
          'avatar': this.userAvatar,
          'token': this.userToken,
          'page_offset': this.pageOffset,
          'question_offset': this.questionOffset
        },
      ),
    );
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

    final String url = 'http://192.168.0.7:8000/register';
    // final String url = 'http://192.168.0.105:8000/register';
    if (email == "" || username == "" || password == "" || password2 == "") {
      setResponse("Please Fill all the fields!", 400);
    } else {
      setLoading(true);
      var body = {
        'email': email,
        'username': username,
        'password': password,
        'password2': password2,
        'avatar': avatars.first,
        'page_offset': "1",
        'question_offset': "10"
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
    final String url = 'http://192.168.0.7:8000/login';
    // final String url = 'http://192.168.0.105:8000/login';

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

  Future<Map<int, int>> getPageDetails() async {
    final String url = 'http://192.168.0.7:8000/get-page/';
    String token;
    getUserToken().then((value) {
      token = value;
    });
    var response = await http.post(url, body: {'token': token});
    Map responseBody = json.decode(response.body);
    if (response.statusCode == 202) {
      return responseBody;
    }
    throw Exception();
  }

  String getUserAvatar() {
    return userAvatar;
  }

  UserResponse getUser() {
    return user;
  }

  Map getResponse() {
    return {'responseMessage': responseMessage, 'responseCode': responseCode};
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

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  Future<void> setResponse(message, code) {
    responseMessage = message;
    responseCode = code;
    notifyListeners();
    return null;
  }

  String getUserEmail() {
    return userEmail;
  }

  String getUserName() {
    return userName;
  }

  bool isUser() {
    return user == null ? false : user.token == null ? false : true;
  }

  void setUserEmail(email, _sprefs) async {
    userEmail = email;
    _sprefs.setString('userEmail', userEmail);
    notifyListeners();
  }

  Future<void> setUserName(username, _sprefs, {update = false}) async {
    if (update) {
      SharedPreferences _sprefs = await SharedPreferences.getInstance();

      setLoading(true);
      final String url = 'http://192.168.0.7:8000/update-account/';
      //final String url = 'http://192.168.0.105:8000/update-account/';
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

  void setUserToken(token, _sprefs) async {
    userToken = token;
    _sprefs.setString('userToken', userToken);
    notifyListeners();
  }

  Future<String> getUserToken() async {
    SharedPreferences _sprefs = await SharedPreferences.getInstance();
    return _sprefs.getString('userToken');
  }

  void setUserAvatar(avatar, _sprefs, {update = false}) async {
    if (update) {
      SharedPreferences _sprefs = await SharedPreferences.getInstance();

      setLoading(true);
      final String url = 'http://192.168.0.7:8000/update-account/';
      //final String url = 'http://192.168.0.105:8000/update-account/';
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

  void incrementQuestionDetails() async {
    final String url = 'http://192.168.0.7:8000/update-account/';
    //final String url = 'http://192.168.0.105:8000/update-account/';
    int questionOffset;
    getPageDetails().then((value) {
      questionOffset = value['question_offset'] + 1;
    });
    var response = await http.put(url, body: {
      'question_offset': questionOffset,
      'token': userToken,
    });
    Map responseBody = json.decode(response.body);
    if (response.statusCode == 202) {
      await setResponse(responseBody['message'], 202);
    } else {
      await setResponse(responseBody['error_message'], response.statusCode);
    }
  }

  void incrementPageDetails() async {
    final String url = 'http://192.168.0.7:8000/update-account/';
    //final String url = 'http://192.168.0.105:8000/update-account/';
    int pageOffset;
    getPageDetails().then((value) {
      pageOffset = value['page_offset'] + 1;
    });
    var response = await http.put(url, body: {
      'page_offset': pageOffset,
      'token': userToken,
    });
    Map responseBody = json.decode(response.body);
    if (response.statusCode == 202) {
      await setResponse(responseBody['message'], 202);
    } else {
      await setResponse(responseBody['error_message'], response.statusCode);
    }
  }
}

class PageInformation {
  Future<Map<String, dynamic>> getPageDetails() async {
    final String url = 'http://192.168.0.7:8000/get-page/';
    //final String url = 'http://192.168.0.105:8000/get-page/';
    Map responseBody;
    var response;
    SharedPreferences _sprefs = await SharedPreferences.getInstance();
    String token = _sprefs.getString('userToken');
    response = await http.post(url, body: {"token": token});
    responseBody = json.decode(response.body);
    if (response.statusCode == 202) {
      return responseBody;
    } else {
      throw Exception('Could\'nt get Future');
    }
  }

  Future<int> incrementPageDetails(int previousPage) async {
    final String url = 'http://192.168.0.7:8000/update-account/';
    //final String url = 'http://192.168.0.105:8000/update-account/';
    SharedPreferences _sprefs = await SharedPreferences.getInstance();
    String token = _sprefs.getString('userToken');
    int increment = previousPage + 1;
    var response = await http.put(url, body: {
      'token': token,
      'page_offset': increment.toString(),
    });
    Map responseBody = json.decode(response.body);
    if (response.statusCode == 202) {
      return increment;
    } else {
      print(responseBody['error_message']);
    }
  }

  void incrementQuestionDetails(int index) async {
    final String url = 'http://192.168.0.7:8000/update-account/';
    //final String url = 'http://192.168.0.105:8000/update-account/';
    SharedPreferences _sprefs = await SharedPreferences.getInstance();
    String token = _sprefs.getString('userToken');
    var response = await http.put(url, body: {
      'token': token,
      'question_offset': index.toString(),
    });
    Map responseBody = json.decode(response.body);
    if (response.statusCode != 202) {
      print(responseBody['error_message']);
    }
  }
}
