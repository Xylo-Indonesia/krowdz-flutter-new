class DashboardActivity {
  bool status;
  Data data;

  DashboardActivity({this.status, this.data});

  DashboardActivity.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  bool enable;
  List<Activity> activity;

  Data({this.enable, this.activity});

  Data.fromJson(Map<String, dynamic> json) {
    enable = json['enable'];
    if (json['activity'] != null) {
      activity = new List<Activity>();
      json['activity'].forEach((v) {
        activity.add(new Activity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enable'] = this.enable;
    if (this.activity != null) {
      data['activity'] = this.activity.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Activity {
  int id;
  String name;
  int total;
  String icon;
  String achievement;

  Activity({this.id, this.name, this.total, this.icon, this.achievement});

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    total = json['total'];
    icon = json['icon'];
    achievement = json['achievement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['total'] = this.total;
    data['icon'] = this.icon;
    data['achievement'] = this.achievement;
    return data;
  }
}
