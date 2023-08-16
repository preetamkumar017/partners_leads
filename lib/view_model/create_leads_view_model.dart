
import 'package:flutter/material.dart';
import 'package:partners_leads/repository/create_leads_repository.dart';
import 'package:partners_leads/utils/routes/routes_name.dart';
import 'package:partners_leads/utils/utils.dart';

class CreateLeadsViewModel with ChangeNotifier {

  final _myRepo = CreateLeadsRepository();

  bool _signUpLoading = false ;
  bool get loading => _signUpLoading ;



  setCreateLeadsLoading(bool value){
    _signUpLoading = value;
    notifyListeners();
  }


  Future<void> createLeads(dynamic files,dynamic data , BuildContext context) async {
    setCreateLeadsLoading(true);

    _myRepo.createLeadsApi(files,data).then((value){
      setCreateLeadsLoading(false);
      if (value.code == 200) {
      setImageValue("");
      setAudioValue("");

      Utils.flushBarErrorMessage('CreateLeads Successfully', context);

      Navigator.pushReplacementNamed(context, RoutesName.leadsList);
       } else {
        Utils.flushBarErrorMessage("Something went wrong", context);
      }

    }).onError((error, stackTrace){
      setCreateLeadsLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);      
    });
  }


  bool _deleteLeads = false ;
  bool get deleteLoading => _deleteLeads ;
  setDeleteLeadsLoading(bool value){
    _deleteLeads = value;
    notifyListeners();
  }
  Future<void> deleteClientApi (dynamic data , BuildContext context)async{
    setDeleteLeadsLoading(false);
    _myRepo.deleteLeadsApi(data).then((value){
      if (value.code == 200) {
        Utils.flushBarSuccessMessage('Leads delete Successfully', context);
      } else {
        Utils.flushBarErrorMessage("Something went wrong", context);
      }
    }).onError((error, stackTrace){
      setDeleteLeadsLoading(false);
    });
  }


  String audio = "";
  String get audioValue=>audio;
  setAudioValue(String value){audio = value;notifyListeners();}

  
  String image = "";
  String get imageValue=>audio;
  setImageValue(String value){image = value;notifyListeners();}

}