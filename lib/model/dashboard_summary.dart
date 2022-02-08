class DashboardSummary {
  bool status;
  Data data;

  DashboardSummary({this.status, this.data});

  DashboardSummary.fromJson(Map<String, dynamic> json) {
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
  int totalVisitor;
  Online online;
  Online offline;

  Data({this.totalVisitor, this.online, this.offline});

  Data.fromJson(Map<String, dynamic> json) {
    totalVisitor = json['total_visitor'];
    online =
    json['online'] != null ? new Online.fromJson(json['online']) : null;
    offline =
    json['offline'] != null ? new Online.fromJson(json['offline']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_visitor'] = this.totalVisitor;
    if (this.online != null) {
      data['online'] = this.online.toJson();
    }
    if (this.offline != null) {
      data['offline'] = this.offline.toJson();
    }
    return data;
  }
}

class Online {
  bool enable;
  int total;
  String percentage;

  Online({this.enable, this.total, this.percentage});

  Online.fromJson(Map<String, dynamic> json) {
    enable = json['enable'];
    total = json['total'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enable'] = this.enable;
    data['total'] = this.total;
    data['percentage'] = this.percentage;
    return data;
  }
}
