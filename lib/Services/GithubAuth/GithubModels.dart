class GitHubLoginRequest {
  String clientId;
  String clientSecret;
  String code;

  GitHubLoginRequest({this.clientId, this.clientSecret, this.code});

  dynamic toJson() =>
      {
        "client_id": clientId,
        "client_secret": clientSecret,
        "code": code,
      };
}

class GitHubLoginResponse {
  String accessToken;
  String tokenType;
  String scope;

  GitHubLoginResponse({this.accessToken, this.tokenType, this.scope});

  factory GitHubLoginResponse.fromJson(Map<String, dynamic> json) =>
      GitHubLoginResponse(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        scope: json["scope"],
      );
}

class GithubModel {
  String email;
  bool primary;
  bool verified;
  String visibility;

  GithubModel({this.email, this.primary, this.verified, this.visibility});

  GithubModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    primary = json['primary'];
    verified = json['verified'];
    visibility = json['visibility'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['primary'] = this.primary;
    data['verified'] = this.verified;
    data['visibility'] = this.visibility;
    return data;
  }
}