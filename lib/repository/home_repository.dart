
import 'package:partners_leads/data/network/BaseApiServices.dart';
import 'package:partners_leads/data/network/NetworkApiService.dart';
import 'package:partners_leads/model/movies_model.dart';
import 'package:partners_leads/res/app_url.dart';

class HomeRepository {

  BaseApiServices _apiServices = NetworkApiService() ;

  Future<MovieListModel> fetchMoviesList()async{
    AppUrl.changeApi();

    try{

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);
      return response = MovieListModel.fromJson(response);

    }catch(e){
      throw e ;
    }
  }

}