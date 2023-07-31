class SignupModel {
  int? code;
  String? status;
  Result? result;

  SignupModel({this.code, this.status, this.result});

  SignupModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? employeeName;
  String? empType;
  String? rule;
  String? email;
  String? password;
  String? address;
  String? mobileNo;
  dynamic watsappNo;
  dynamic empImg;
  String? createdBy;
  String? createdOn;
  dynamic updatedBy;
  dynamic updatedOn;
  String? userAuth;
  String? eDOptn;
  String? planValue;
  String? planDuration;
  String? validUpto;
  String? status;
  String? emailVerified;
  String? transid;
  String? paymentStatus;
  String? refCode;
  String? groupCode;
  String? memberCode;
  dynamic macAddress;
  String? groupLeader;
  dynamic partnerGroup;
  String? createDate;
  String? ip;
  String? groupAccess;

  Result(
      {this.id,
        this.employeeName,
        this.empType,
        this.rule,
        this.email,
        this.password,
        this.address,
        this.mobileNo,
        this.watsappNo,
        this.empImg,
        this.createdBy,
        this.createdOn,
        this.updatedBy,
        this.updatedOn,
        this.userAuth,
        this.eDOptn,
        this.planValue,
        this.planDuration,
        this.validUpto,
        this.status,
        this.emailVerified,
        this.transid,
        this.paymentStatus,
        this.refCode,
        this.groupCode,
        this.memberCode,
        this.macAddress,
        this.groupLeader,
        this.partnerGroup,
        this.createDate,
        this.ip,
        this.groupAccess});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeName = json['employee_name'];
    empType = json['emp_type'];
    rule = json['rule'];
    email = json['email'];
    password = json['password'];
    address = json['address'];
    mobileNo = json['mobile_no'];
    watsappNo = json['watsapp_no'];
    empImg = json['emp_img'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
    userAuth = json['user_auth'];
    eDOptn = json['e_d_optn'];
    planValue = json['plan_value'];
    planDuration = json['plan_duration'];
    validUpto = json['valid_upto'];
    status = json['status'];
    emailVerified = json['email_verified'];
    transid = json['transid'];
    paymentStatus = json['payment_status'];
    refCode = json['ref_code'];
    groupCode = json['group_code'];
    memberCode = json['member_code'];
    macAddress = json['mac_address'];
    groupLeader = json['group_leader'];
    partnerGroup = json['partner_group'];
    createDate = json['create_date'];
    ip = json['ip'];
    groupAccess = json['group_access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_name'] = this.employeeName;
    data['emp_type'] = this.empType;
    data['rule'] = this.rule;
    data['email'] = this.email;
    data['password'] = this.password;
    data['address'] = this.address;
    data['mobile_no'] = this.mobileNo;
    data['watsapp_no'] = this.watsappNo;
    data['emp_img'] = this.empImg;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    data['user_auth'] = this.userAuth;
    data['e_d_optn'] = this.eDOptn;
    data['plan_value'] = this.planValue;
    data['plan_duration'] = this.planDuration;
    data['valid_upto'] = this.validUpto;
    data['status'] = this.status;
    data['email_verified'] = this.emailVerified;
    data['transid'] = this.transid;
    data['payment_status'] = this.paymentStatus;
    data['ref_code'] = this.refCode;
    data['group_code'] = this.groupCode;
    data['member_code'] = this.memberCode;
    data['mac_address'] = this.macAddress;
    data['group_leader'] = this.groupLeader;
    data['partner_group'] = this.partnerGroup;
    data['create_date'] = this.createDate;
    data['ip'] = this.ip;
    data['group_access'] = this.groupAccess;
    return data;
  }
}
