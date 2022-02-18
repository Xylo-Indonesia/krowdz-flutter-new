import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  bool? status;
  @HiveField(1)
  String? message;
  @HiveField(2)
  Data? data;

  User({this.status, this.message, this.data});

  User.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 2)
class Data {
  @HiveField(3)
  String? name;
  @HiveField(4)
  String? email;
  @HiveField(5)
  String? role;
  @HiveField(6)
  List<Permissions>? permissions;
  @HiveField(7)
  String? accessToken;

  Data({this.name, this.email, this.role, this.permissions, this.accessToken});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
    if (json['permissions'] != null) {
      permissions = [];
      json['permissions'].forEach((v) {
        permissions!.add(new Permissions.fromJson(v));
      });
    }
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    if (this.permissions != null) {
      data['permissions'] = this.permissions!.map((v) => v.toJson()).toList();
    }
    data['access_token'] = this.accessToken;
    return data;
  }
}

@HiveType(typeId: 3)
class Permissions {
  @HiveField(8)
  int? id;
  @HiveField(9)
  String? name;
  @HiveField(10)
  String? displayName;
  @HiveField(11)
  String? description;
  @HiveField(12)
  String? createdAt;
  @HiveField(13)
  String? updatedAt;
  @HiveField(14)
  Pivot? pivot;

  Permissions(
      {this.id,
      this.name,
      this.displayName,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Permissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['display_name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['display_name'] = this.displayName;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 4)
class Pivot {
  @HiveField(15)
  int? userId;
  @HiveField(16)
  int? permissionId;
  @HiveField(17)
  String? userType;

  Pivot({this.userId, this.permissionId, this.userType});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    permissionId = json['permission_id'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['permission_id'] = this.permissionId;
    data['user_type'] = this.userType;
    return data;
  }
}
