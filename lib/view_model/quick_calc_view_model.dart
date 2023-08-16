import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partners_leads/data/response/status.dart';
import 'package:partners_leads/model/QuickCalcListModel.dart';
import 'package:partners_leads/repository/quick_calc_repository.dart';
import 'package:partners_leads/view_model/services/static_value.dart';

class QuickCalcController extends GetxController
{
  final _quickCalcRepository = QuickCalcRepository();

  Rx<TextEditingController> mobile = TextEditingController().obs;
  Rx<TextEditingController> length = TextEditingController().obs;
  Rx<TextEditingController> width = TextEditingController().obs;
  Rx<TextEditingController> floorNumber = TextEditingController().obs;
  Rx<TextEditingController> rate = TextEditingController().obs;

  RxList<bool> floor = <bool>[false,false,false,false,false,false,false,false,false,false].obs;

  Rx<Status> _status = Status.LOADING.obs;
  get getStatus => _status.value;
  set setStatus(Status value)=>_status.value = value;

  Rx<QuickCalcListModel> _calcList = QuickCalcListModel().obs;
  QuickCalcListModel get getCalcList => _calcList.value;
  set setCalcList(QuickCalcListModel value)=>_calcList.value=value;

  void insertCalcData()
  {
    Map data = {

        };
    _quickCalcRepository.insertCalcData(data).then((value) {
      if(value.code==200)
      {

      }else if(value.code==201){

      }else{

      }
    }).onError((error, stackTrace) {

    });
  }

  void calcListData()
  {
    setStatus = Status.LOADING;
    Map data = {
      "user_id":MyStaticValue.id,
      "req_type":"quick_calc_list",
        };
    _quickCalcRepository.calcListDataApi(data).then((value) {
      if(value.code==200)
      {
        if(value.records!.isNotEmpty) {
          setStatus = Status.COMPLETED;
          setCalcList = value;
        }else
          {
            setStatus = Status.EMPTY;
          }
      }else{

        setStatus = Status.ERROR;
      }
    }).onError((error, stackTrace) {

      setStatus = Status.ERROR;
    });
  }

  void deleteCalcData(String id)
  {
    Map data = {
      "id":id,
      "req_type":"quick_calc_delete",
        };
    _quickCalcRepository.deleteCalcData(data).then((value) {
      if(value.code==200)
      {

        Get.snackbar("Delete Successfully", "");
        calcListData();
      }else{
        Get.snackbar("Something Went Wrong", "");
      }
    }).onError((error, stackTrace) {

    });
  }
}