class Webhook {
  Webhook({
    this.id,
    this.requestedExecutionDate,
    this.executionDate,
    this.result,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.monitorId,
  });

  Webhook.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    requestedExecutionDate = DateTime.tryParse((json['requestedExecutionDate'] ?? '') as String);
    executionDate = DateTime.tryParse((json['executionDate'] ?? '') as String);
    result = json['result'] as String?;
    json['status'] == 'active' ? status = true : status = false;
    createdAt = DateTime.tryParse((json['createdAt'] ?? '') as String); /// meglio cosi?
    updatedAt = DateTime.tryParse((json['updatedAt']  ?? '') as String);
    monitorId = json['projectId'] as String?;
  }

  String? id;
  DateTime? requestedExecutionDate;
  DateTime? executionDate;
  String? result;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? monitorId;

}
