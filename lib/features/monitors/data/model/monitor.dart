class Monitor {
  Monitor({
    this.id,
    this.name,
    this.type,
    this.url,
    this.httpMethod,
    this.minutesInterval,
    this.secondsTimeout,
    this.checkSsl,
    this.customHeaders,
    this.customBody,
    this.matchResponseString,
    this.emailAddresses,
    this.lastCheckDate,
    this.lastCheckStatus,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.projectId,
    //this.project,
  });

  //Project? project;

  Monitor.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    type = json['type'] as String?;
    url = json['url'] as String?;
    httpMethod = json['httpMethod'] as String?;
    minutesInterval = double.tryParse(json['minutesInterval'] as String); ///TODO() FARE CONTROLLI SU QUESTO PARSE
    secondsTimeout = double.tryParse(json['secondsTimeout'] as String);
    checkSsl = json['checkSsl']?.toString();
    customHeaders = json['customHeaders'] as String?;
    customBody = json['customBody'] as String?;
    matchResponseString = json['matchResponseString'] as String?;
    emailAddresses = json['emailAddresses'] as String?;
    lastCheckDate = DateTime.tryParse(json['lastCheckDate'] as String);
    lastCheckStatus = json['lastCheckStatus'] as String?;
    json['status'] == 'active' ? status = true : status = false;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    projectId = json['projectId'] as String?;
    //project = json['project'] != null ? Project.fromJson(json['project']) : null;
  }

  String? id;
  String? name;
  String? type;
  String? url;
  String? httpMethod;
  double? minutesInterval;
  double? secondsTimeout;
  String? checkSsl;
  String? customHeaders;
  String? customBody;
  String? matchResponseString;
  String? emailAddresses;
  DateTime? lastCheckDate;
  String? lastCheckStatus;
  bool? status;
  String? createdAt;
  String? updatedAt;
  String? projectId;

}
