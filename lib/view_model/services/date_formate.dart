import 'dart:developer';

import 'package:intl/intl.dart';

class MyDateFormate {
  static ddMMMyyyy(var data) {
    if (data == null) {
      return "";
    }
    var inputDate = DateTime.parse(data.toString());
    var outputFormat = DateFormat('dd-MMM-yyyy');
    var outputDate = outputFormat.format(inputDate);
    if (outputDate == "01-Jan-1970") {
      outputDate = "";
    }
    return outputDate;
  }
}
