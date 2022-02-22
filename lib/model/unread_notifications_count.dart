class UnreadNotificationsCount {
  bool? status;
  Data? data;

  UnreadNotificationsCount({this.status, this.data});

  UnreadNotificationsCount.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? total;
  int? general;
  int? announcements;

  Data({this.total, this.general, this.announcements});

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    general = json['general'];
    announcements = json['announcements'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['general'] = this.general;
    data['announcements'] = this.announcements;

    return data;
  }
}
