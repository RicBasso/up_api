class LostPasswordResponse {
  LostPasswordResponse({required this.success, this.data, this.code});

  LostPasswordResponse.fromJson(Map<String, dynamic> json) {
    if (json['success'] is bool) {
      success = json['success'] as bool;
    }
    if (success == true) {
      if (json['data'] is bool) {
        data = json['data'] as bool;
      }
    } else {
      if (json['success'] is bool) {
        code = json['code'] as String;
      }
    }
  }
  late bool success;
  bool? data;
  String? code;
}
