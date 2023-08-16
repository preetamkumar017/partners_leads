class PriceRateModel {
  int? code;
  String? status;
  List<Result>? result;

  PriceRateModel({this.code, this.status, this.result});

  PriceRateModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? id;
  String? floorPrice;
  String? status;
  String? createDate;
  String? ip;

  Result({this.id, this.floorPrice, this.status, this.createDate, this.ip});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    floorPrice = json['floor_price'];
    status = json['status'];
    createDate = json['create_date'];
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['floor_price'] = floorPrice;
    data['status'] = status;
    data['create_date'] = createDate;
    data['ip'] = ip;
    return data;
  }
}
