// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:partners_leads/model/arguments.dart';
import 'package:partners_leads/model/auth_model.dart';
import 'package:partners_leads/utils/routes/routes_name.dart';
import 'package:partners_leads/view_model/services/static_value.dart';
import 'package:partners_leads/view_model/user_view_model.dart';

class SplashServices {
  Future<AuthModel> getUserDate() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserDate().then((value) async {
      MyStaticValue.id = value.id.toString();
      MyStaticValue.login_name = value.employeeName.toString();
      MyStaticValue.emp_type = value.empType.toString();
      MyStaticValue.email = value.email.toString();
      MyStaticValue.status = value.status.toString();
      MyStaticValue.paymentStatus = value.paymentStatus.toString();
      MyStaticValue.address = value.address.toString();
      MyStaticValue.mobile = value.mobileNo.toString();
      MyStaticValue.regDate = value.createDate.toString();
      MyStaticValue.validUpto = value.validUpto.toString();
      MyStaticValue.planValue = value.planValue.toString();
      MyStaticValue.planDuration = value.planDuration.toString();
      MyStaticValue.groupCode = value.groupCode.toString();
      MyStaticValue.groupAccess = value.groupAccess.toString();
      MyStaticValue.memberCode = value.memberCode.toString();

      Map data = {
        'id': value.id.toString(),
        'email': value.email.toString(),
        'empType': value.empType.toString(),
        'employeeName': value.employeeName.toString(),
        'validUpto': value.validUpto.toString(),
        'status': value.status.toString(),
        'paymentStatus': value.paymentStatus.toString(),
        'group_code': value.memberCode.toString(),
      };
      if (value.empType.toString() == "4" &&
          (value.status.toString() == "0" || value.status.toString() == null)) {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RoutesName.refral);
      } else if (value.email.toString() == 'null' ||
          value.email.toString() == '') {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RoutesName.login);
      } else {
        DateTime dt1 = DateTime.parse(MyStaticValue.validUpto);
        DateTime dt2 = DateTime.now();
        if (dt2.compareTo(dt1) < 0) {
          MyStaticValue.valid = true;
        } else {
          MyStaticValue.valid = false;
        }

        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacementNamed(context,
            RoutesName.dashboard,
            arguments: ScreenArguments(data));
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
