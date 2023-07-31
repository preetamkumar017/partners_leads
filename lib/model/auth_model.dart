class AuthModel {
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
  String? createDate;
  String? ip;
  String? groupCode;
  String? memberCode;
  String? groupAccess;

  AuthModel({
    this.id,
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
    this.groupAccess,
  });

  AuthModel.fromJson(Map<String, dynamic> json) {
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
    groupAccess = json['group_access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['group_access'] = groupAccess;
    return data;
  }
}