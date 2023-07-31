class LeadsModel {
  int? code;
  String? status;
  List<Result>? result;
  List<PartnerNameId>? partnerNameId;

  LeadsModel({this.code, this.status, this.result, this.partnerNameId});

  LeadsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
    if (json['partner_name_id'] != null) {
      partnerNameId = <PartnerNameId>[];
      json['partner_name_id'].forEach((v) {
        partnerNameId!.add(new PartnerNameId.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    if (this.partnerNameId != null) {
      data['partner_name_id'] =
          this.partnerNameId!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? id;
  String? loginId;
  String? loginName;
  String? loginType;
  String? isPrivate;
  String? clientName;
  String? clientMob;
  String? addDate;
  String? leadFrom;
  String? workDetail;
  String? followupById;
  String? followupByName;
  String? teamWork;
  String? meeting;
  String? meetDoneDate;
  String? meetDate;
  String? notes;
  dynamic dealDoneDate;
  dynamic dealAmount;
  String? status;
  String? prevFupDate;
  String? fupDate;
  String? nextFupDate;
  dynamic lastDelayFup;
  String? quoteReq;
  String? quoteFile;
  String? brokerId;
  String? brokerName;
  String? brokerEmail;
  String? newEmpId;
  String? memberCode;
  String? plotSize;
  String? sizeType;
  String? location;
  String? audioFile;
  String? imgpdfFile;
  String? createDate;
  String? updateDate;
  String? ip;
  String? employeeName;

  Result(
      {this.id,
      this.loginId,
      this.loginName,
      this.loginType,
      this.isPrivate,
      this.clientName,
      this.clientMob,
      this.addDate,
      this.leadFrom,
      this.workDetail,
      this.followupById,
      this.followupByName,
      this.teamWork,
      this.meeting,
      this.meetDoneDate,
      this.meetDate,
      this.notes,
      this.dealDoneDate,
      this.dealAmount,
      this.status,
      this.prevFupDate,
      this.fupDate,
      this.nextFupDate,
      this.lastDelayFup,
      this.quoteReq,
      this.quoteFile,
      this.brokerId,
      this.brokerName,
      this.brokerEmail,
      this.newEmpId,
      this.memberCode,
      this.plotSize,
      this.sizeType,
      this.location,
      this.audioFile,
      this.imgpdfFile,
      this.createDate,
      this.updateDate,
      this.ip,
      this.employeeName});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loginId = json['login_id'];
    loginName = json['login_name'];
    loginType = json['login_type'];
    isPrivate = json['is_private'];
    clientName = json['client_name'];
    clientMob = json['client_mob'];
    addDate = json['add_date'];
    leadFrom = json['lead_from'];
    workDetail = json['work_detail'];
    followupById = json['followup_by_id'];
    followupByName = json['followup_by_name'];
    teamWork = json['team_work'];
    meeting = json['meeting'];
    meetDoneDate = json['meet_done_date'];
    meetDate = json['meet_date'];
    notes = json['notes'];
    dealDoneDate = json['deal_done_date'];
    dealAmount = json['deal_amount'];
    status = json['status'];
    prevFupDate = json['prev_fup_date'];
    fupDate = json['fup_date'];
    nextFupDate = json['next_fup_date'];
    lastDelayFup = json['last_delay_fup'];
    quoteReq = json['quote_req'];
    quoteFile = json['quote_file'];
    brokerId = json['broker_id'];
    brokerName = json['broker_name'];
    brokerEmail = json['broker_email'];
    newEmpId = json['new_emp_id'];
    memberCode = json['member_code'];
    plotSize = json['plot_size'];
    sizeType = json['size_type'];
    location = json['location'];
    audioFile = json['audio_file'];
    imgpdfFile = json['imgpdf_file'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    ip = json['ip'];
    employeeName = json['employee_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login_id'] = this.loginId;
    data['login_name'] = this.loginName;
    data['login_type'] = this.loginType;
    data['is_private'] = this.isPrivate;
    data['client_name'] = this.clientName;
    data['client_mob'] = this.clientMob;
    data['add_date'] = this.addDate;
    data['lead_from'] = this.leadFrom;
    data['work_detail'] = this.workDetail;
    data['followup_by_id'] = this.followupById;
    data['followup_by_name'] = this.followupByName;
    data['team_work'] = this.teamWork;
    data['meeting'] = this.meeting;
    data['meet_done_date'] = this.meetDoneDate;
    data['meet_date'] = this.meetDate;
    data['notes'] = this.notes;
    data['deal_done_date'] = this.dealDoneDate;
    data['deal_amount'] = this.dealAmount;
    data['status'] = this.status;
    data['prev_fup_date'] = this.prevFupDate;
    data['fup_date'] = this.fupDate;
    data['next_fup_date'] = this.nextFupDate;
    data['last_delay_fup'] = this.lastDelayFup;
    data['quote_req'] = this.quoteReq;
    data['quote_file'] = this.quoteFile;
    data['broker_id'] = this.brokerId;
    data['broker_name'] = this.brokerName;
    data['broker_email'] = this.brokerEmail;
    data['new_emp_id'] = this.newEmpId;
    data['member_code'] = this.memberCode;
    data['plot_size'] = this.plotSize;
    data['size_type'] = this.sizeType;
    data['location'] = this.location;
    data['audio_file'] = this.audioFile;
    data['imgpdf_file'] = this.imgpdfFile;
    data['create_date'] = this.createDate;
    data['update_date'] = this.updateDate;
    data['ip'] = this.ip;
    data['employee_name'] = this.employeeName;
    return data;
  }
}

class PartnerNameId {
  String? id;
  String? employeeName;

  PartnerNameId({this.id, this.employeeName});

  PartnerNameId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeName = json['employee_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_name'] = this.employeeName;
    return data;
  }
}