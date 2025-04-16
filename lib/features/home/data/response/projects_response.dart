import 'package:up_api/features/home/data/model/project.dart';

class ProjectsResponse {
  ProjectsResponse({
    required this.success,
    this.projectsBody,
    this.code,
    this.count,
  });

  ProjectsResponse.fromJson(Map<String, dynamic> json) {
    if (json['success'] is bool) {
      success = json['success'] as bool;
    }
    if (success == true) {
      count = json['count'] as int;
      if (json['data'] is List) {
        projectsBody = [];
        (json['data'] as List<dynamic>).forEach((element) {
          projectsBody?.add(Project.fromJson(element as Map<String, dynamic>));
        });
      }
    } else {
      if (json['success'] is bool) {
        code = json['code'] as String;
      }
    }
  }
  late bool success;
  List<Project?>? projectsBody;
  String? code;
  int? count;
}
