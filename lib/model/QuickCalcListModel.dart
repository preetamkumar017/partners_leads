class QuickCalcListModel {
  int? code;
  String? status;
  List<Records>? records;

  QuickCalcListModel({this.code, this.status, this.records});

  QuickCalcListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(Records.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    if (records != null) {
      data['records'] = records!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Records {
  String? id;
  String? mobile;
  String? length;
  String? width;
  String? floor;
  String? rate;
  String? openArea;
  String? openAreaCost;
  String? totalArea;
  String? totalAreaCost;
  String? totalFalseCeilingCast;
  String? totalFalseCeilingArea;
  String? bwallAreaWithHeight;
  String? bwallCost;
  String? stankCost;
  String? wtankCost;
  String? projectCost;
  String? status;
  String? createBy;
  String? createDate;
  String? updateDate;
  String? ip;

  Records(
      {this.id,
        this.mobile,
        this.length,
        this.width,
        this.floor,
        this.rate,
        this.openArea,
        this.openAreaCost,
        this.totalArea,
        this.totalAreaCost,
        this.totalFalseCeilingCast,
        this.totalFalseCeilingArea,
        this.bwallAreaWithHeight,
        this.bwallCost,
        this.stankCost,
        this.wtankCost,
        this.projectCost,
        this.status,
        this.createBy,
        this.createDate,
        this.updateDate,
        this.ip});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobile = json['mobile'];
    length = json['length'];
    width = json['width'];
    floor = json['floor'];
    rate = json['rate'];
    openArea = json['open_area'];
    openAreaCost = json['open_area_cost'];
    totalArea = json['total_area'];
    totalAreaCost = json['total_area_cost'];
    totalFalseCeilingCast = json['total_false_ceiling_cast'];
    totalFalseCeilingArea = json['total_false_ceiling_area'];
    bwallAreaWithHeight = json['bwall_area_with_height'];
    bwallCost = json['bwall_cost'];
    stankCost = json['stank_cost'];
    wtankCost = json['wtank_cost'];
    projectCost = json['project_cost'];
    status = json['status'];
    createBy = json['create_by'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mobile'] = mobile;
    data['length'] = length;
    data['width'] = width;
    data['floor'] = floor;
    data['rate'] = rate;
    data['open_area'] = openArea;
    data['open_area_cost'] = openAreaCost;
    data['total_area'] = totalArea;
    data['total_area_cost'] = totalAreaCost;
    data['total_false_ceiling_cast'] = totalFalseCeilingCast;
    data['total_false_ceiling_area'] = totalFalseCeilingArea;
    data['bwall_area_with_height'] = bwallAreaWithHeight;
    data['bwall_cost'] = bwallCost;
    data['stank_cost'] = stankCost;
    data['wtank_cost'] = wtankCost;
    data['project_cost'] = projectCost;
    data['status'] = status;
    data['create_by'] = createBy;
    data['create_date'] = createDate;
    data['update_date'] = updateDate;
    data['ip'] = ip;
    return data;
  }
}
