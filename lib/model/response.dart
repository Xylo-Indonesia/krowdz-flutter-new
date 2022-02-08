class Response{
  String status;
  Object data;
  Object message;

  Response(this.status, this.data,this.message);
  Response.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    data = json['data'];
    message=json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] = this.data;
    data['message']=this.message;
    return data;
  }
}