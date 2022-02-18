class VerifyRequest {
  String? code;

  VerifyRequest({this.code});

  VerifyRequest.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code.toString();
    return data;
  }
}