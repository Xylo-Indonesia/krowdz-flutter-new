class NotificationCreate {
  String title;
  String message;
  List recipients;
  bool isAllUsers;

  NotificationCreate(
      {required this.title,
      required this.message,
      required this.recipients,
      required this.isAllUsers});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = 'general';
    data['title'] = title;
    data['message'] = message;
    data['recipients'] = recipients;
    data['is_all_users'] = isAllUsers;

    return data;
  }
}

class Users {
  bool? status;
  List<User> data = [];
  String? message;

  Users({this.status, required this.data, this.message});

  Users.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(User.fromJson(v));
      });
    }
  }
}

class User {
  late int id;
  late String name;
  String? email;
  String? role;

  User({required this.id, required this.name, this.email, this.role});

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
