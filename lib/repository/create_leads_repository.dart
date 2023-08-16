
import 'package:partners_leads/data/network/BaseApiServices.dart';
import 'package:partners_leads/data/network/NetworkApiService.dart';
import 'package:partners_leads/model/result_model.dart';
import 'package:partners_leads/res/app_url.dart';

class CreateLeadsRepository  {

  final BaseApiServices _apiServices = NetworkApiService() ;

  
  Future<ResultModel> createLeadsApi(dynamic files, dynamic data )async{
    AppUrl.changeApi();
    try{
      dynamic response = await _apiServices.getPostWithFormDataApiResponse(AppUrl.addLeadEndPoint,files, data);
      return response = ResultModel.fromJson(response);
    }catch(e){
      throw e ;
    }
  }

  Future<ResultModel>  deleteLeadsApi( dynamic data )async{
    AppUrl.changeApi();
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.addLeadEndPoint, data);
      return response = ResultModel.fromJson(response);
    }catch(e){
      throw e ;
    }
  }

  


}

