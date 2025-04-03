class Monitor {

  Monitor({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.companyId,
  });

  Monitor.fromJson(Map<String, dynamic> json){
    id = json['id'] as String?;
    name = json['name'] as String?;
    status = json['status'] as bool?;
    createdAt = json['createdAt'] as DateTime?;
    updatedAt = json['updatedAt'] as DateTime?;
    companyId = json['companyId'] as String?;
  }

  String? id;
  String? name;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? companyId;

}