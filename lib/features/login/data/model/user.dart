class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.recoveryNumber,
    this.recoveryNumberDate,
    this.refreshToken,
    this.lastAccess,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.userGroupId,
    this.companyId,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    firstName = json['firstName'] as String?;
    lastName = json['lastName'] as String?;
    email = json['email'] as String?;
    password = json['password'] as String?;
    recoveryNumber = json['recoveryNumber'] as String?;
    recoveryNumberDate = json['recoveryNumberDate'] as String?;
    refreshToken = json['refreshToken'] as String?;
    lastAccess = json['lastAccess'] as String?;
    status = json['status'] as String?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    userGroupId = json['userGroupId'] as String?;
    companyId = json['companyId'] as String?;
  }
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? recoveryNumber;
  String? recoveryNumberDate;
  String? refreshToken;
  String? lastAccess;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? userGroupId;
  String? companyId;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['recoveryNumber'] = recoveryNumber;
    data['recoveryNumberDate'] = recoveryNumberDate;
    data['refreshToken'] = refreshToken;
    data['lastAccess'] = lastAccess;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['userGroupId'] = userGroupId;
    data['companyId'] = companyId;
    return data;
  }
}
