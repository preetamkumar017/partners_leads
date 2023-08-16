import 'dart:developer';
import 'package:get/get.dart';
import 'package:partners_leads/data/response/status.dart';
import 'package:partners_leads/model/price_rate_model.dart';
import 'package:partners_leads/repository/quick_calc_repository.dart';

class PriceListController extends GetxController
{

  final _quickCalcRepository = QuickCalcRepository();

  Rx<Status> _status = Status.LOADING.obs;
  get getStatus => _status.value;
  set setStatus(Status value)=>_status.value = value;


  Rx<PriceRateModel> _priceRate = PriceRateModel().obs;
  PriceRateModel get getPriceRate => _priceRate.value;
  set setPriceRate(PriceRateModel value)=>_priceRate.value=value;
  RxList<bool> rate = <bool>[].obs;


  void getData()
  {
    setStatus = Status.LOADING;
    Map data = {
      "req_type":"rate_list"
    };
    _quickCalcRepository.fetchPriceList(data).then((value)
    {
      log(value.toJson().toString());
      if(value.code==200 )
        {
          if(value.result!.isNotEmpty)
            {
              rate.clear();

              setStatus = Status.COMPLETED;
              setPriceRate = value;
              value.result!.forEach((element) {
                rate.add(false);
              });
            }else
              {

                setStatus = Status.EMPTY;
              }
        }else
        {

          setStatus = Status.ERROR;
        }

    }).onError((error, stackTrace) {
      log(error.toString());

      setStatus = Status.ERROR;
    });
  }


}