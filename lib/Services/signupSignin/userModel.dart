class UserResponse {
  String response;
  String email;
  String username;
  String token;
  String avatar;

  UserResponse(
      {this.response, this.email, this.username, this.token, this.avatar});

  UserResponse.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    email = json['email'];
    username = json['username'];
    token = json['token'];
    avatar = json['avatar'];
  }
}
