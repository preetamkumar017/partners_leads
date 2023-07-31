class UserModel {
  int? code;
  String? status;
  List<Result>? result;

  UserModel({this.code, this.status, this.result});

  UserModel.fromJson(Map<String, dynamic> json) {
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
  String? employeeName;
  String? empType;
  String? rule;
  String? email;
  String? password;
  dynamic address;
  String? mobileNo;
  String? watsappNo;
  String? empImg;
  String? createdBy;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;
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
  String? createDate;
  String? ip;
  String? groupCode;
  String? memberCode;
  String? macAddress;
  String? partnerGroup;
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
        this.createDate,
        this.ip,
        this.groupCode,
        this.memberCode,
        this.macAddress,
        this.partnerGroup,
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
    createDate = json['create_date'];
    ip = json['ip'];
    groupCode = json['group_code'];
    memberCode = json['member_code'];
    macAddress = json['mac_address'];
    partnerGroup = json['partner_group'];
    groupAccess = json['group_access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_name'] = employeeName;
    data['emp_type'] = empType;
    data['rule'] = rule;
    data['email'] = email;
    data['password'] = password;
    data['address'] = address;
    data['mobile_no'] = mobileNo;
    data['watsapp_no'] = watsappNo;
    data['emp_img'] = empImg;
    data['created_by'] = createdBy;
    data['created_on'] = createdOn;
    data['updated_by'] = updatedBy;
    data['updated_on'] = updatedOn;
    data['user_auth'] = userAuth;
    data['e_d_optn'] = eDOptn;
    data['plan_value'] = planValue;
    data['plan_duration'] = planDuration;
    data['valid_upto'] = validUpto;
    data['status'] = status;
    data['email_verified'] = emailVerified;
    data['transid'] = transid;
    data['payment_status'] = paymentStatus;
    data['ref_code'] = refCode;
    data['create_date'] = createDate;
    data['ip'] = ip;
    data['group_code'] = groupCode;
    data['member_code'] = memberCode;
    data['mac_address'] = macAddress;
    data['partner_group'] = partnerGroup;
    data['group_access'] = groupAccess;
    return data;
  }
}
