import 'package:up_api/features/home/data/model/project.dart';

class MonitorsResponse{
  MonitorsResponse({required this.success,this.monitorsBody, this.code});

  MonitorsResponse.fromJson(Map<String, dynamic> json) {
    if (json['success'] is bool) {
      success = json['success'] as bool;
    }
    if (success == true) {
      if (json['data'] is List<Map<String, dynamic>>) {
          for (final element in (json['data'] as List<Map<String, dynamic>>)) {
              monitorsBody?.add(Project.fromJson(element));
          }
      }
    } else {
      if (json['success'] is bool) {
        code = json['code'] as String;
      }
    }
  }
  late bool success;
  List<Project?>? monitorsBody;
  String? code;
}
