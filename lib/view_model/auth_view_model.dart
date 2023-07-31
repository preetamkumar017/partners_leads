import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:partners_leads/model/auth_model.dart';
import 'package:partners_leads/res/components/my_alert.dart';
import 'package:partners_leads/respository/auth_repository.dart';
import 'package:partners_leads/utils/routes/routes_name.dart';
import 'package:partners_leads/utils/utils.dart';
import 'package:partners_leads/view_model/services/static_value.dart';
import 'package:partners_leads/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      if (value.code == 200) {
        final userPreference =
            Provider.of<UserViewModel>(context, listen: false);
        userPreference.saveUser(AuthModel(
          id: value.result![0].id,
          email: value.result![0].email,
          empType: value.result![0].empType,
          employeeName: value.result![0].employeeName,
          validUpto: value.result![0].validUpto,
          status: value.result![0].status,
          paymentStatus: value.result![0].paymentStatus,
          mobileNo: value.result![0].mobileNo,
          address: value.result![0].address,
          createDate: value.result![0].createDate,
          planValue: value.result![0].planValue,
          planDuration: value.result![0].planDuration,
          groupCode: value.result![0].groupCode,
          groupAccess: value.result![0].groupAccess,
          memberCode: value.result![0].memberCode
        ));

        MyStaticValue.id = value.result![0].id.toString();
        MyStaticValue.emp_type = value.result![0].empType.toString();
        MyStaticValue.login_name = value.result![0].employeeName.toString();
        MyStaticValue.email = value.result![0].email.toString();
        MyStaticValue.status = value.result![0].status.toString();
        MyStaticValue.paymentStatus = value.result![0].paymentStatus.toString();
        MyStaticValue.address = value.result![0].address.toString();
        MyStaticValue.mobile = value.result![0].mobileNo.toString();
        MyStaticValue.regDate = value.result![0].createDate.toString();
        MyStaticValue.validUpto = value.result![0].validUpto.toString();
        MyStaticValue.planValue = value.result![0].planValue.toString();
        MyStaticValue.planDuration = value.result![0].planDuration.toString();
        MyStaticValue.groupCode = value.result![0].groupCode.toString();
        MyStaticValue.groupAccess = value.result![0].groupAccess.toString();
        MyStaticValue.memberCode = value.result![0].memberCode.toString();

        DateTime dt1 = DateTime.parse(MyStaticValue.validUpto);
        DateTime dt2 = DateTime.now();
        if (dt2.compareTo(dt1) < 0) {
          MyStaticValue.valid = true;
        } else {
          MyStaticValue.valid = false;
        }

        if (MyStaticValue.emp_type.toString() == "4" &&
            (MyStaticValue.status.toString() == "0" ||
                MyStaticValue.status.toString() == null)) {
          Navigator.pushReplacementNamed(context, RoutesName.refral);
        } else {
          Navigator.pushReplacementNamed(context, RoutesName.leadsList);
        }
      } else if (value.code == 201) {
        MyAlert.deviceRequest(context, data);
      } else {
        Utils.flushBarErrorMessage('Please check email or password', context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);
    _myRepo.signUpApi(data).then((value) async {
      if (value.code == 200) {
        // Utils.flushBarErrorMessage('SignUp Successfully Please Login', context);
        Fluttertoast.showToast(msg: "SignUp Successfully");
        log(value.toJson().toString());


        Map mailData = {
          'ref_code':value.result!.refCode ?? "",
          'name':value.result!.employeeName ?? "",
          'email':value.result!.email ?? "",
          'pass':base64.encode(utf8.encode(value.result!.password ?? ""))
      };
        log(mailData.toString());
      await  mail(mailData);

        setSignUpLoading(false);
        Navigator.pop(context);
      } else if (value.code == 500) {
        Utils.flushBarErrorMessage("email: ${value.status}", context);
        Fluttertoast.showToast(msg: "email: ${value.status}");
      } else {
        Utils.flushBarErrorMessage("Something wrong", context);
        Fluttertoast.showToast(msg: "Something wrong");
      }
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }


  Future<void> mail(data) async {
    _myRepo.mailApi(data).then((value) {
      log("mail send method"+value.toJson().toString());
      if(value.code==200)
        {
          Fluttertoast.showToast(msg: "Mail Send Successfully");
        }else
          {
            Fluttertoast.showToast(msg: "Mail not Send! Please Contact to IT team ");
          }
    }).onError((error, stackTrace) {

    });
  }


  bool refarralLoading = false;
  bool get getRefarralLoading => refarralLoading;

  setRefarralLoading(bool refarralLoading) {
    this.refarralLoading = refarralLoading;
  }

  Future<void> refarralApi(dynamic data, BuildContext context) async {
    setRefarralLoading(true);
    _myRepo.addRefrral(data).then((value) async {
      setRefarralLoading(false);
      if (value.code == 200) {
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString("status", "1");
        Navigator.pushReplacementNamed(context, RoutesName.leadsList);
      } else {
        Utils.flushBarErrorMessage("Wrong code please try again...", context);
      }
    }).onError((error, stackTrace) {
      setRefarralLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  bool passwordLoading = false;
  bool get getPasswordLoading => passwordLoading;

  setPasswordLoading(bool passwordLoading) {
    this.passwordLoading = passwordLoading;
  }

  Future<void> passwordApi(dynamic data, BuildContext context) async {
    setPasswordLoading(true);
    _myRepo.addRefrral(data).then((value) async {
      setPasswordLoading(false);
      if (value.code == 200) {
        Fluttertoast.showToast(msg: "Password Successfully Changed...");
        Navigator.pushReplacementNamed(context, RoutesName.profile);
      } else {
        Utils.flushBarErrorMessage("Wrong code please try again...", context);
      }
    }).onError((error, stackTrace) {
      setPasswordLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  Future<void> addDeviceApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);
    _myRepo.addDeviceApi(data).then((value) {
      setSignUpLoading(false);
      log(value.toJson().toString());
      if (value.code == 200) {
        Fluttertoast.showToast(msg: "Successfully Sent");
        Navigator.pop(context);
      } else {
        Utils.flushBarErrorMessage("Something wrong", context);
        Fluttertoast.showToast(msg: "Something wrong");
      }
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

}
