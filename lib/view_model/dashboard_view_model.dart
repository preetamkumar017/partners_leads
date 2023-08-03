
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:partners_leads/data/response/api_response.dart';
import 'package:partners_leads/model/dashbord_model.dart';
import 'package:partners_leads/respository/dashbord_repository.dart';
import 'package:partners_leads/utils/routes/routes_name.dart';
import 'package:partners_leads/utils/utils.dart';
import 'package:partners_leads/view_model/services/static_value.dart';
import 'package:partners_leads/view_model/user_view_model.dart';

class DashboardViewModel with ChangeNotifier {
  final _myRepo = DashboardRepository();

  ApiResponse<DashboardModel> dashboard = ApiResponse.loading();


  setDashboard(ApiResponse<DashboardModel> response) {
    dashboard = response;
    // totalLeads = response.data!.result!.length;
    notifyListeners();
  }

  Future<void> fetchLeadsApi( BuildContext context) async {
    setDashboard(ApiResponse.loading());
    Map data = {
      "req_type":"dashboard",
      "pid":MyStaticValue.id,
      "login_type":MyStaticValue.emp_type,
    };

    _myRepo.fetchDashboard(data).then((value) async {
      log(value.toJson().toString());
      if(value.code == 200)
      {
        setDashboard(ApiResponse.completed(value));
      }else if(value.code==403)
      {
        setDashboard(ApiResponse.error(value.status.toString()));
        UserViewModel.remove();
        Navigator.pushReplacementNamed(context, RoutesName.splash);
        Utils.toastMessage("You do not have permission");
      }else
      {
        setDashboard(ApiResponse.error("Something Went Wrong"));
      }
    }).onError((error, stackTrace) {
      setDashboard(ApiResponse.error(error.toString()));
    });
  }

}