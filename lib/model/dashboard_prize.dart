class DashboardPrize {
  bool? status;
  Data? data;

  DashboardPrize({this.status, this.data});

  DashboardPrize.fromJson(Map<String, dynamic> json) {
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
  bool? enable;
  List<Prize>? prize;

  Data({this.enable, this.prize});

  Data.fromJson(Map<String, dynamic> json) {
    enable = json['enable'];
    if (json['merchandises'] != null) {
      prize = [];
      json['merchandises'].forEach((v) {
        prize!.add(Prize.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enable'] = this.enable;
    if (this.prize != null) {
      data['merchandises'] = this.prize!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prize {
  int? id;
  String? name;
  String? image;
  int? remaining;
  int? total;
  List<MerchandiseActivity>? activities;

  Prize(
      {this.id,
      this.name,
      this.image,
      this.remaining,
      this.total,
      this.activities});

  Prize.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image_path'];
    remaining = json['remaining_stock'];
    total = json['total_stock'];

    if (json['activities'] != null) {
      activities = [];
      json['activities'].forEach((v) {
        activities!.add(MerchandiseActivity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image_path'] = this.image;
    data['remaining_stock'] = this.remaining;
    data['total_stock'] = this.total;
    data['activities'] = this.activities;

    return data;
  }
}

class MerchandiseActivity {
  int? id;
  String? name;
  String? icon;

  MerchandiseActivity({this.id, this.name, this.icon});

  MerchandiseActivity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;

    return data;
  }
}
