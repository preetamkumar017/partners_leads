class ResultModel {
  int? code;
  String? status;

  ResultModel({this.code, this.status});

  ResultModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    return data;
  }
}