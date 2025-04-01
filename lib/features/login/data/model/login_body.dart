import 'package:up_api/features/login/data/model/user.dart';

class LoginBody {
  LoginBody({this.userId, this.user, this.accessToken, this.refreshToken});

  LoginBody.fromJson(Map<String, dynamic> json) {
    if (json['userId'] is String?) {
      userId = json['userId'] as String?;
    }

    if (json['user'] is Map<String, dynamic>) {
      user = User.fromJson(json['user'] as Map<String, dynamic>);
    } else {
      user = null;
    }

    if (json['accessToken'] is String) {
      accessToken = json['accessToken'] as String;
    }

    if (json['refreshToken'] is String) {
      refreshToken = json['refreshToken'] as String;
    }
  }
  String? userId;
  User? user;
  String? accessToken;
  String? refreshToken;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    return data;
  }
}
