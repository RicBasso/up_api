import 'package:up_api/features/login/data/model/login_body.dart';

class LoginResponse {
  LoginResponse({required this.success, this.loginBody, this.code});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    if (json['success'] is bool) {
      success = json['success'] as bool;
    }
    if (success == true) {
      if (json['data'] is Map<String, dynamic>) {
        loginBody = LoginBody.fromJson(json['data'] as Map<String, dynamic>);
      }
    } else {
      if (json['success'] is bool) {
        code = json['code'] as String;
      }
    }
  }
  late bool success;
  LoginBody? loginBody;
  String? code;
}
