import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart';
import 'package:partners_leads/data/app_excaptions.dart';
import 'package:partners_leads/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 60));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    log(url);
    log(data.toString());
    dynamic responseJson;
    try {
      Response response = await post(Uri.parse(url), body: data).timeout(const Duration(seconds: 60));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPostWithFormDataApiResponse(String url, file, data) async {
    dynamic responseJson;
    dynamic responseString;
    // print(file);
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.fields.addAll(data);
      request.files.addAll(file);
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      responseString = String.fromCharCodes(responseData);

      responseJson = returnResponseFile(response, responseString);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponseFile(http.StreamedResponse response, responseString) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(responseString);
        return responseJson;
      case 400:
        throw BadRequestException(response.stream.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.stream.toString());
      default:
        throw FetchDataException(
            'Error accured while communicating with server with status code' +
                response.statusCode.toString());
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error accured while communicating with server' +
                'with status code' +
                response.statusCode.toString());
    }
  }
}
