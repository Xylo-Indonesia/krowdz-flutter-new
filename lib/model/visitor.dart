class Visitor {
  List<Data> data;
  Links links;
  Meta meta;

  Visitor({this.data, this.links, this.meta});

  Visitor.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String name;
  String gender;
  String email;
  String phoneNumber;
  String code;
  String type;
  bool isExpired;
  String expiredAt;
  String createdAt;

  Data(
      {this.id,
      this.name,
      this.gender,
      this.email,
      this.phoneNumber,
      this.code,
      this.type,
      this.isExpired,
      this.expiredAt,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    code = json['alphanumeric_code'];
    type = json['type'];
    isExpired = json['is_expired'];
    expiredAt = json['expired_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['alphanumeric_code'] = this.code;
    data['type'] = this.type;
    data['is_expired'] = this.isExpired;
    data['expired_at'] = this.expiredAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Links {
  String first;
  String last;
  String prev;
  String next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}

class Meta {
  int currentPage;
  int from;
  int lastPage;
  String path;
  int perPage;
  int to;
  int total;
  Keymapper keymapper;

  Meta(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.path,
      this.perPage,
      this.to,
      this.total,
      this.keymapper});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
    keymapper = json['keymapper'] != null
        ? new Keymapper.fromJson(json['keymapper'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    if (this.keymapper != null) {
      data['keymapper'] = this.keymapper.toJson();
    }
    return data;
  }
}

class Keymapper {
  String code;
  String gender;
  String type;
  String phoneNumber;
  String city;
  String email;

  Keymapper(
      {this.code,
      this.gender,
      this.type,
      this.phoneNumber,
      this.city,
      this.email});

  Keymapper.fromJson(Map<String, dynamic> json) {
    code = json['alphanumeric_code'];
    gender = json['gender'];
    type = json['type'];
    phoneNumber = json['phone_number'];
    city = json['city'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alphanumeric_code'] = this.code;
    data['gender'] = this.gender;
    data['type'] = this.type;
    data['phone_number'] = this.phoneNumber;
    data['city'] = this.city;
    data['email'] = this.email;
    return data;
  }
}
