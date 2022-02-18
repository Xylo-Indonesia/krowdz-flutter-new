class Version {
  String? latestVersion;
  dynamic update;

  Version({this.latestVersion, this.update});

  Version.fromJson(Map<String, dynamic> json) {
    latestVersion = json['latest_version'];
    update = json['update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latest_version'] = this.latestVersion;
    data['update'] = this.update;
    return data;
  }
}
