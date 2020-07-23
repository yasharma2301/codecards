class UserResponse {
  String response;
  String email;
  String username;
  String avatar;
  String token;
  int pageOffset;
  int questionOffset;

  UserResponse(
      {this.response,
      this.email,
      this.username,
      this.avatar,
      this.token,
      this.pageOffset,
      this.questionOffset});

  UserResponse.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    email = json['email'];
    username = json['username'];
    avatar = json['avatar'];
    token = json['token'];
    pageOffset = json['page_offset'];
    questionOffset = json['question_offset'];
  }
}
