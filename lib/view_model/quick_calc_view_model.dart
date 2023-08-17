import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partners_leads/data/response/status.dart';
import 'package:partners_leads/model/QuickCalcListModel.dart';
import 'package:partners_leads/repository/quick_calc_repository.dart';
import 'package:partners_leads/utils/utils.dart';
import 'package:partners_leads/view_model/services/static_value.dart';

class QuickCalcController extends GetxController
{
  final _quickCalcRepository = QuickCalcRepository();


  RxString id = "".obs;
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

  Future<void> insertCalcData(BuildContext context)
  async {
    if(mobile.value.text==""){
      Utils.flushBarErrorMessage("Please Enter Mobile Number", context);
    }else if(length.value.text==""){
      Utils.flushBarErrorMessage("Please Enter Length", context);
    }else if(width.value.text==""){
      Utils.flushBarErrorMessage("Please Enter Width", context);
    }else if(rate.value.text==""){
      Utils.flushBarErrorMessage("Please Enter Rate", context);
    }else if(floorNumber.value.text==""){
      Utils.flushBarErrorMessage("Please Enter Floor Number", context);
    }else{
      setStatus = Status.LOADING;
      Map data = {
        "id": id.value.toString(),
        "user_id": MyStaticValue.id,
        "req_type": "quick_calc_insert",
        "mobile": mobile.value.text,
        "length": length.value.text,
        "width": width.value.text,
        "floor": floorNumber.value.text,
        "rate": rate.value.text,
      };
      _quickCalcRepository.insertCalcData(data).then((value) {
        if (value.code == 200) {
          log("Successfully Calculation Added");
        } else if (value.code == 201) {
          log("Successfully Calculation Updated");
        } else {
          log("Successfully Something Went Wrong");
        }

        Navigator.of(context).pop();
        setStatus = Status.COMPLETED;
      }).onError((error, stackTrace) {
        setStatus = Status.ERROR;
      });

    }
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