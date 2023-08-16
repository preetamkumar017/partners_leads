
import 'package:partners_leads/data/network/BaseApiServices.dart';
import 'package:partners_leads/data/network/NetworkApiService.dart';
import 'package:partners_leads/model/QuickCalcListModel.dart';
import 'package:partners_leads/model/price_rate_model.dart';
import 'package:partners_leads/model/result_model.dart';
import 'package:partners_leads/res/app_url.dart';

class QuickCalcRepository {

  final BaseApiServices _apiServices = NetworkApiService();


  Future<PriceRateModel> fetchPriceList(dynamic data) async {
    AppUrl.changeApi();
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.addLeadEndPoint,data);
      return response = PriceRateModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
  Future<QuickCalcListModel> insertCalcData(dynamic data) async {
    AppUrl.changeApi();
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.addLeadEndPoint,data);
      return response = QuickCalcListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
  Future<QuickCalcListModel> calcListDataApi(dynamic data) async {
    AppUrl.changeApi();
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.addLeadEndPoint,data);
      return response = QuickCalcListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
  Future<ResultModel> deleteCalcData(dynamic data) async {
    AppUrl.changeApi();
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.addLeadEndPoint,data);
      return response = ResultModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}