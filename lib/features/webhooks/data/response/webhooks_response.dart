import 'package:up_api/features/webhooks/data/model/webhook.dart';

class WebhooksResponse {
  WebhooksResponse({
    required this.success,
    this.webhooksBody,
    this.code,
    this.count,
  });

  WebhooksResponse.fromJson(Map<String, dynamic> json) {
    if (json['success'] is bool) {
      success = json['success'] as bool;
    }
    if (success == true) {
      count = json['count'] as int;
      if (json['data'] is List) {
        webhooksBody = [];
        (json['data'] as List<dynamic>).forEach((element) {
          webhooksBody?.add(Webhook.fromJson(element as Map<String, dynamic>));
        });
      }
    } else {
      if (json['success'] is bool) {
        code = json['code'] as String;
      }
    }
  }
  late bool success;
  List<Webhook?>? webhooksBody;
  String? code;
  int? count;
}
