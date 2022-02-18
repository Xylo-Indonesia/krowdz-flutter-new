class ScanResult {
  Data? data;
  bool? status;
  String? message;
  Meta? meta;

  ScanResult({this.data, this.status, this.message, this.meta});

  ScanResult.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? gender;
  String? email;
  String? phoneNumber;
  String? code;
  String? type;
  String? activity;
  String? job;
  String? city;
  bool? isExpired;
  String? expiredAt;
  String? createdAt;
  History? history;

  Data({this.id, this.name, this.gender, this.email, this.phoneNumber, this.code, this.type, this.activity, this.job, this.city, this.isExpired, this.expiredAt, this.createdAt, this.history});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    code = json['code'];
    type = json['type'];
    activity = json['activity'];
    job = json['job'];
    city = json['city'];
    isExpired = json['is_expired'];
    expiredAt = json['expired_at'];
    createdAt = json['created_at'];
    history = json['history'] != null ? new History.fromJson(json['history']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['code'] = this.code;
    data['type'] = this.type;
    data['activity'] = this.activity;
    data['job'] = this.job;
    data['city'] = this.city;
    data['is_expired'] = this.isExpired;
    data['expired_at'] = this.expiredAt;
    data['created_at'] = this.createdAt;
    if (this.history != null) {
      data['history'] = this.history!.toJson();
    }
    return data;
  }
}

class History {


  History();

History.fromJson(Map<String, dynamic>? json) {
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  return data;
}
}

class Meta {
  Keymapper? keymapper;

  Meta({this.keymapper});

  Meta.fromJson(Map<String, dynamic> json) {
    keymapper = json['keymapper'] != null ? new Keymapper.fromJson(json['keymapper']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.keymapper != null) {
      data['keymapper'] = this.keymapper!.toJson();
    }
    return data;
  }
}

class Keymapper {
  String? name;
  String? code;
  String? gender;
  String? type;
  String? phoneNumber;
  String? city;
  String? email;

  Keymapper({this.name, this.code, this.gender, this.type, this.phoneNumber, this.city, this.email});

  Keymapper.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    gender = json['gender'];
    type = json['type'];
    phoneNumber = json['phone_number'];
    city = json['city'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['gender'] = this.gender;
    data['type'] = this.type;
    data['phone_number'] = this.phoneNumber;
    data['city'] = this.city;
    data['email'] = this.email;
    return data;
  }
}
