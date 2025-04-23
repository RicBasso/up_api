class RefreshTokenResponse {
  RefreshTokenResponse({required this.success, this.token, this.code});

  RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    //log(json.toString());
    success = json['success'] as bool;
    if (success == true) {
      token = json['data'] as String?;
    } else {
      code = json['code'] as String?;
    }
  }

  late bool success;
  String? token;
  String? code;
}
