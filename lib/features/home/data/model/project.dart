import 'package:up_api/features/monitors/data/model/monitor.dart';

class Project {
  Project({this.id, this.name, this.status, this.createdAt, this.updatedAt, this.companyId, this.monitor});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    json['status'] == 'active' ? status = true : status = false;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    companyId = json['companyId'] as String?;
    for (final element in (json['monitors'] as List<dynamic>)) {
      monitor = Monitor.fromJson(element as Map<String, dynamic>);
    }
  }

  String? id;
  String? name;
  bool? status;
  String? createdAt;
  String? updatedAt;
  String? companyId;
  Monitor? monitor;
}
