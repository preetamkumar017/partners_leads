
import 'package:partners_leads/data/network/BaseApiServices.dart';
import 'package:partners_leads/data/network/NetworkApiService.dart';
import 'package:partners_leads/model/dashbord_model.dart';
import 'package:partners_leads/res/app_url.dart';

class DashboardRepository {

  final BaseApiServices _apiServices = NetworkApiService();


  Future<DashboardModel> fetchDashboard(dynamic data) async {
    AppUrl.changeApi();
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.addLeadEndPoint, data);
      return response = DashboardModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}