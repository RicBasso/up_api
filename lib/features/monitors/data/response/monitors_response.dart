import 'package:up_api/features/monitors/data/model/monitor.dart';

class MonitorsResponse {
  MonitorsResponse({required this.success, this.monitorsBody, this.code, this.count});

  MonitorsResponse.fromJson(Map<String, dynamic> json) {
    if (json['success'] is bool) {
      success = json['success'] as bool;
    }
    if (success == true) {
      count = json['count'] as int;
      if (json['data'] is List) {
        monitorsBody = [];
        for (final element in (json['data'] as List<dynamic>)) {
          monitorsBody?.add(Monitor.fromJson(element as Map<String, dynamic>));
        }
      }
    } else {
      if (json['success'] is bool) {
        code = json['code'] as String;
      }
    }
  }
  late bool success;
  List<Monitor?>? monitorsBody;
  String? code;
  int? count;
}
