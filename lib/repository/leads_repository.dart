
import 'package:partners_leads/data/network/BaseApiServices.dart';
import 'package:partners_leads/data/network/NetworkApiService.dart';
import 'package:partners_leads/model/followup_details_model.dart';
import 'package:partners_leads/model/leads_model.dart';
import 'package:partners_leads/model/leads_with_group_model.dart';
import 'package:partners_leads/model/result_model.dart';
import 'package:partners_leads/res/app_url.dart';

class LeadsRepository  {

  final BaseApiServices _apiServices = NetworkApiService() ;

  
  Future<LeadsModel> fatchLeads(dynamic data )async{
    AppUrl.changeApi();
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.addLeadEndPoint, data);
      return response = LeadsModel.fromJson(response);
    }catch(e){
      throw e ;
    }
  }


  Future<LeadsWithGroupModel> fatchLeadsWithGroup(dynamic data )async{
    AppUrl.changeApi();
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.addLeadEndPoint, data);
      return response = LeadsWithGroupModel.fromJson(response);
    }catch(e){
      throw e ;
    }
  }




  Future<FollowupDetailsModel> fatchFollowupDetails(dynamic data )async{
    AppUrl.changeApi();
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.addLeadEndPoint, data);
      return response = FollowupDetailsModel.fromJson(response);
    }catch(e){
      throw e ;
    }
  }
  
  Future<ResultModel> addFollowupDetails(dynamic data )async{
    AppUrl.changeApi();
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.addLeadEndPoint, data);
      return response = ResultModel.fromJson(response);

    }catch(e){
      throw e ;
    }
  }

  Future<ResultModel> addFollowupDetailsWithData(dynamic file,dynamic data )async{
    AppUrl.changeApi();
    try{
      dynamic response = await _apiServices.getPostWithFormDataApiResponse(AppUrl.addLeadEndPoint,file, data);
      // print(ResultModel.fromJson(response));
      return response = ResultModel.fromJson(response);
    }catch(e){
      throw e ;
    }
  }

}

