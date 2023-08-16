import 'dart:developer';
import 'package:partners_leads/data/network/BaseApiServices.dart';
import 'package:partners_leads/data/network/NetworkApiService.dart';
import 'package:partners_leads/model/result_model.dart';
import 'package:partners_leads/model/signup_model.dart';
import 'package:partners_leads/model/user_model.dart';
import 'package:partners_leads/res/app_url.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<UserModel> loginApi(dynamic data) async {
    AppUrl.changeApi();
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.addLeadEndPoint, data);
      response = UserModel.fromJson(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<SignupModel> signUpApi(dynamic data) async {
    AppUrl.changeApi();
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.addLeadEndPoint, data);
      return SignupModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<ResultModel> mailApi(dynamic data) async {
    AppUrl.changeApi();
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(AppUrl.mailEndPoint, data);
      return ResultModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<ResultModel> addRefrral(dynamic data) async {
    AppUrl.changeApi();
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.addLeadEndPoint, data);
      return response = ResultModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<ResultModel> password(dynamic data) async {
    AppUrl.changeApi();
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.addLeadEndPoint, data);
      return response = ResultModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<ResultModel> addDeviceApi(dynamic data) async {
    AppUrl.changeApi();
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.addLeadEndPoint, data);
      return ResultModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
