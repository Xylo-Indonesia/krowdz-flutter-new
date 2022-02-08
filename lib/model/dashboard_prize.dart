class DashboardPrize {
  bool status;
  Data data;

  DashboardPrize({this.status, this.data});

  DashboardPrize.fromJson(Map<String, dynamic> json) {
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
  List<Prize> prize;

  Data({this.enable, this.prize});

  Data.fromJson(Map<String, dynamic> json) {
    enable = json['enable'];
    if (json['prize'] != null) {
      prize = new List<Prize>();
      json['prize'].forEach((v) {
        prize.add(new Prize.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enable'] = this.enable;
    if (this.prize != null) {
      data['prize'] = this.prize.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prize {
  int id;
  String name;
  String image;
  int total;

  Prize({this.id, this.name, this.image, this.total});

  Prize.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['total'] = this.total;
    return data;
  }
}
