class FollowupDetailsModel {
  int? code;
  String? status;
  List<Data>? data;

  FollowupDetailsModel({this.code, this.status, this.data});

  FollowupDetailsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = code;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? clientId;
  String? fupById;
  String? fupByName;
  String? prevFupDate;
  String? fupDate;
  String? nextFupDate;
  String? lastDelayFup;
  String? meeting;
  String? status;
  String? remarks;
  Null? quoteReq;
  Null? quoteFile;
  String? audioFile;
  String? imgpdfFile;
  String? createDate;
  String? updateDate;
  String? ip;

  Data(
      {this.id,
      this.clientId,
      this.fupById,
      this.fupByName,
      this.prevFupDate,
      this.fupDate,
      this.nextFupDate,
      this.lastDelayFup,
      this.meeting,
      this.status,
      this.remarks,
      this.quoteReq,
      this.quoteFile,
      this.audioFile,
      this.imgpdfFile,
      this.createDate,
      this.updateDate,
      this.ip});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    fupById = json['fup_by_id'];
    fupByName = json['fup_by_name'];
    prevFupDate = json['prev_fup_date'];
    fupDate = json['fup_date'];
    nextFupDate = json['next_fup_date'];
    lastDelayFup = json['last_delay_fup'];
    meeting = json['meeting'];
    status = json['status'];
    remarks = json['remarks'];
    quoteReq = json['quote_req'];
    quoteFile = json['quote_file'];
    audioFile = json['audio_file'];
    imgpdfFile = json['imgpdf_file'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['client_id'] = clientId;
    data['fup_by_id'] = fupById;
    data['fup_by_name'] = fupByName;
    data['prev_fup_date'] = prevFupDate;
    data['fup_date'] = fupDate;
    data['next_fup_date'] = nextFupDate;
    data['last_delay_fup'] = lastDelayFup;
    data['meeting'] = meeting;
    data['status'] = status;
    data['remarks'] = remarks;
    data['quote_req'] = quoteReq;
    data['quote_file'] = quoteFile;
    data['audio_file'] = audioFile;
    data['imgpdf_file'] = imgpdfFile;
    data['create_date'] = createDate;
    data['update_date'] = updateDate;
    data['ip'] = ip;
    return data;
  }
}