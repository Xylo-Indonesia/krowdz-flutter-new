import 'package:hive/hive.dart';

part 'client.g.dart';

@HiveType(typeId: 0)
class Client extends HiveObject{
  @HiveField(0) String code;
  @HiveField(1) String name;
  @HiveField(2) String logo;
  @HiveField(3) String apiUrl;
  @HiveField(4) String expiredAt;

  Client({this.code, this.name, this.logo, this.apiUrl, this.expiredAt});

  Client.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    logo = json['logo'];
    apiUrl = json['api_url'];
    expiredAt = json['expired_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['api_url'] = this.apiUrl;
    data['expired_at'] = this.expiredAt;
    return data;
  }
}
