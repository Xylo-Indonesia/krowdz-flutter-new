class ActivityHistoryData {
  int? id;
  String? name;
  String? description;
  String? category;
  bool? rewardAvailable;
  int? permissionId;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;

  ActivityHistoryData(
      {this.id,
      this.name,
      this.description,
      this.category,
      this.rewardAvailable,
      this.permissionId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  ActivityHistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    category = json['type'];
    rewardAvailable = json['reward_available'];
    permissionId = json['permission_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.category;
    data['reward_available'] = this.rewardAvailable;
    data['permission_id'] = this.permissionId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
