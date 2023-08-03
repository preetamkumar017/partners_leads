class DashboardModel {
  int? code;
  String? status;
  Result? result;

  DashboardModel({this.code, this.status, this.result});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? total;
  String? totalDealDone;

  Result({this.total, this.totalDealDone});

  Result.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalDealDone = json['total_deal_done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['total_deal_done'] = this.totalDealDone;
    return data;
  }
}
