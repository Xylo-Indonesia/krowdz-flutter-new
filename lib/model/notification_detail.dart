class NotificationDetail {
  bool? status;
  Data? data;
  List<User>? recipients = [];
  List<Reply>? replies = [];
  String? companyLogo;

  NotificationDetail({this.status, this.data, this.recipients, this.replies});

  NotificationDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

    if (data?.type == 'general') {
      if (json['data']['recipients'] != null) {
        recipients = [];
        json['data']['recipients'].forEach((v) {
          recipients?.add(User.fromJson(v));
        });
      }

      if (json['data']['replies'] != null) {
        replies = [];
        json['data']['replies'].forEach((v) {
          replies?.add(Reply.fromJson(v));
        });
      }
    }

    try {
      companyLogo = json['meta']['logo_path'];
    } catch (e) {
      print(json['meta']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status;
    }

    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }

    if (this.recipients != null) {
      data['recipients'] = this.recipients?.map((v) => v.toJson()).toList();
    }

    if (this.replies != null) {
      data['replies'] = this.replies?.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Data {
  int? id;
  String? type;
  String? category;
  String? title;
  String? message;
  String? createdAt;
  User? sender;

  Data(
      {this.id,
      this.type,
      this.category,
      this.title,
      this.message,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    category = json['category'];
    title = json['title'];
    message = json['message'];
    createdAt = json['created_at'];

    if (json['sender'] != null) {
      sender = User.fromJson(json['sender']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['title'] = this.title;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    data['sender'] = this.sender?.toJson();

    return data;
  }
}

class Reply {
  int? id;
  String? message;
  String? createdAt;
  User? sender;

  Reply({this.id, this.message, this.createdAt, this.sender});

  Reply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    createdAt = json['created_at'];

    if (json['sender'] != null) {
      sender = User.fromJson(json['sender']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    data['sender'] = this.sender?.toJson();

    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? role;

  User({this.id, this.name, this.email, this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;

    return data;
  }
}
