import 'package:flutter/cupertino.dart';
import 'package:partners_leads/model/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(AuthModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('id', user.id.toString());
    sp.setString('email', user.email.toString());
    sp.setString('empType', user.empType.toString());
    sp.setString('employeeName', user.employeeName.toString());
    sp.setString('validUpto', user.validUpto.toString());
    sp.setString('status', user.status.toString());
    sp.setString('paymentStatus', user.paymentStatus.toString());
    sp.setString('mobile', user.mobileNo.toString());
    sp.setString('address', user.address.toString());
    sp.setString('createDate', user.createDate.toString());
    sp.setString('planValue', user.planValue.toString());
    sp.setString('planDuration', user.planDuration.toString());
    sp.setString('groupCode', user.groupCode.toString());
    sp.setString('group_access', user.groupAccess.toString());
    sp.setString('memberCode', user.memberCode.toString());
    notifyListeners();
    return true;
  }

  Future<AuthModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    return AuthModel(
      id: sp.getString('id'),
      email: sp.getString('email'),
      empType: sp.getString('empType'),
      employeeName: sp.getString('employeeName'),
      validUpto: sp.getString('validUpto'),
      status: sp.getString('status'),
      paymentStatus: sp.getString('paymentStatus'),
      mobileNo: sp.getString('mobile'),
      address: sp.getString('address'),
      createDate: sp.getString('createDate'),
      planValue: sp.getString('planValue'),
      planDuration: sp.getString('planDuration'),
      groupCode: sp.getString('groupCode'),
      groupAccess: sp.getString('group_access'),
      memberCode: sp.getString('memberCode')
    );
  }

  static Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('id');
    sp.remove('email');
    sp.remove('empType');
    sp.remove('employeeName');
    sp.remove('validUpto');
    sp.remove('status');
    sp.remove('paymentStatus');
    sp.remove('mobile');
    sp.remove('address');
    sp.remove('createDate');
    sp.remove('planValue');
    sp.remove('planDuration');
    sp.remove('groupCode');
    sp.remove('group_access');
    sp.remove('memberCode');
    return true;
  }
}
