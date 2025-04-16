import 'package:up_api/features/login/data/model/user.dart';

class UpdateUserResponse {
  UpdateUserResponse({
    required this.success,
    this.user,
    this.code,
  });

  UpdateUserResponse.fromJson(Map<String, dynamic> json) {
    if (json['success'] is bool) {
      success = json['success'] as bool;
    }
    if (success == true) {
      if (json['data'] is List<User>) {
        (json['data'] as List<dynamic>).forEach((element) {
          user = User.fromJson(element as Map<String, dynamic>);
        });
      }
    } else {
      if (json['success'] is bool) {
        code = json['code'] as String;
      }
    }
  }
  late bool success;
  User? user;
  String? code;
}
