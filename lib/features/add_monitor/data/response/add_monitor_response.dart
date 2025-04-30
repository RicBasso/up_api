import 'package:up_api/features/login/data/model/user.dart';

class AddMonitorResponse {
  AddMonitorResponse({required this.success, this.user, this.code});

  AddMonitorResponse.fromJson(Map<String, dynamic> json) {
    if (json['success'] is bool) {
      success = json['success'] as bool;
    }
    if (success == true) {
      if (json['data'] is Map<String, dynamic>) {
        user = User.fromJson(json['data'] as Map<String, dynamic>);
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
