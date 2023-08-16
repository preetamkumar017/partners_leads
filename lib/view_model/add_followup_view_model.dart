import 'package:flutter/cupertino.dart';
import 'package:partners_leads/data/response/api_response.dart';
import 'package:partners_leads/model/result_model.dart';
import 'package:partners_leads/repository/leads_repository.dart';
import 'package:partners_leads/utils/routes/routes_name.dart';
import 'package:partners_leads/utils/utils.dart';

class AddFollowupViewModel with ChangeNotifier {
  final _myRepo = LeadsRepository();

  ApiResponse<ResultModel> result_model = ApiResponse.loading();

  bool _addFollowupLoading = false;
   get addFollowupLoading => _addFollowupLoading;

  setCreateLeadsLoading(bool value) {
    _addFollowupLoading = value;
    notifyListeners();
  }

  Future<void> addFollowup(dynamic data, BuildContext context) async {
    setCreateLeadsLoading(true);

    _myRepo.addFollowupDetails(data).then((value) {
      setCreateLeadsLoading(false);
      if (value.code == 200) {
        Utils.flushBarSuccessMessage('Followup added Successfully', context);
        Navigator.pushReplacementNamed(context, RoutesName.leadsList);
      } else {
        Utils.flushBarErrorMessage("Something went wrong", context);
      }
    }).onError((error, stackTrace) {
      setCreateLeadsLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  Future<void> addFollowupWithData(dynamic file,dynamic data, BuildContext context) async {
    setCreateLeadsLoading(true);

    _myRepo.addFollowupDetailsWithData(file,data).then((value) {
      setCreateLeadsLoading(false);
      if (value.code == 200) {
        
      setImageValue("");
      setAudioValue("");
        Utils.flushBarSuccessMessage('Followup added Successfully', context);
        Navigator.pushReplacementNamed(context, RoutesName.leadsList);
      } else {
        Utils.flushBarErrorMessage("Something went wrong", context);
      }
    }).onError((error, stackTrace) {
      
      setCreateLeadsLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  String audio = "";
  String get audioValue=>audio;
  setAudioValue(String value){audio = value;notifyListeners();}

  
  String image = "";
  String get imageValue=>audio;
  setImageValue(String value){image = value;notifyListeners();}

  
  bool meet = false;
  bool get meetValue=>meet;
  setMeetValue(bool value){meet = value;notifyListeners();}
}

