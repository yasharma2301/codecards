import 'package:http/http.dart' as http;

class UserResponse {
  String response;
  String email;
  String username;
  String token;

  UserResponse({this.response, this.email, this.username, this.token});

  UserResponse.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    email = json['email'];
    username = json['username'];
    token = json['token'];
  }
}
