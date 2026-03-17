class UserModel {
  String? userId;
  String? email;
  String? password;
  String? verifyToken;
  String? refreshToken;

  UserModel(
      {this.userId, this.email, this.password, this.verifyToken, this.refreshToken});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['_id'];
    email = json['email'];
    password = json['password'];
    verifyToken = json['verifyToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = userId;
    data['email'] = email;
    data['password'] = password;
    data['verifyToken'] = verifyToken;
    data['refreshToken'] = refreshToken;
    return data;
  }
}