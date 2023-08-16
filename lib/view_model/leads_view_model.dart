import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:partners_leads/data/response/api_response.dart';
import 'package:partners_leads/model/followup_details_model.dart';
import 'package:partners_leads/model/leads_model.dart';
import 'package:partners_leads/model/leads_with_group_model.dart';
import 'package:partners_leads/repository/leads_repository.dart';
import 'package:partners_leads/utils/routes/routes_name.dart';
import 'package:partners_leads/utils/utils.dart';
import 'package:partners_leads/view_model/user_view_model.dart';

class LeadsViewModel with ChangeNotifier {
  final _myRepo = LeadsRepository();

  ApiResponse<LeadsModel> leadsList = ApiResponse.loading();
  ApiResponse<LeadsWithGroupModel> leadsWithGroupList = ApiResponse.loading();

  ApiResponse<LeadsModel> search = ApiResponse.loading();

  bool iconSearch = false;

  int totalLeads = 0;

  int get getTotalLeads => totalLeads;

  setTotalLeads(int newTotalLeads)
  {
    totalLeads = newTotalLeads ;
    // notifyListeners();
  }



  bool geticonSearch() {
    return iconSearch;
  }

  seticon(bool icon) {
    iconSearch = icon;
    notifyListeners();
  }

  setLeadsList(ApiResponse<LeadsModel> response) {
    leadsList = response;
    search = leadsList;
    // totalLeads = response.data!.result!.length;
    notifyListeners();
  }




  setLeadsWithGroupList(ApiResponse<LeadsWithGroupModel> response) {
    leadsWithGroupList = response;
    search = leadsList;
    notifyListeners();
  }

  searchdata(String? ss) {
    if (ss != "") {
      seticon(true);
      search.data!.result = leadsList.data!.result!.where(
        (element) {
          if (element.clientName!.toLowerCase().contains(ss!.toLowerCase())) {
            return true;
          } else {
            return false;
          }
        },
      ).toList();
    } else {
      seticon(false);
      search = leadsList;
    }

    notifyListeners();
  }

  ApiResponse<FollowupDetailsModel> followup_details_model =
      ApiResponse.loading();

  setFollowupDetails(ApiResponse<FollowupDetailsModel> response) {
    followup_details_model = response;
    notifyListeners();
  }

  Future<void> fetchLeadsApi(dynamic data, BuildContext context) async {
    setLeadsList(ApiResponse.loading());

    _myRepo.fatchLeads(data).then((value) async {
      if(value.code == 200)
        {
          setLeadsList(ApiResponse.completed(value));
        }else if(value.code==403)
        {
          setLeadsList(ApiResponse.error(value.status.toString()));
          UserViewModel.remove();
          Navigator.pushReplacementNamed(context, RoutesName.splash);
          Utils.toastMessage("You do not have permission");
        }else
          {
            setLeadsList(ApiResponse.error("Something Went Wrong"));
          }
    }).onError((error, stackTrace) {
      setLeadsList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchLeadsWithGroupApi(dynamic data, BuildContext context) async {
    setLeadsWithGroupList(ApiResponse.loading());

    _myRepo.fatchLeadsWithGroup(data).then((value) {
      // print(value.toJson().toString());
      if(value.code==200)
      {
        setLeadsWithGroupList(ApiResponse.completed(value));
      }else
      {
        Utils.flushBarErrorMessage(value.code.toString(), context);
      }
    }).onError((error, stackTrace) {
      setLeadsWithGroupList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchFollowupDetailsApi( dynamic data, BuildContext context) async {
    setFollowupDetails(ApiResponse.loading());

    _myRepo.fatchFollowupDetails(data).then((value) {
       log(value.toString());
      setFollowupDetails(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setFollowupDetails(ApiResponse.error(error.toString()));
    });
  }
}
