import 'package:partners_leads/view_model/services/static_value.dart';

class AppUrl {
  // static var baseUrl = 'http://192.168.1.4/uk_app/android_api/' ;
  // static var baseUrl = 'http://192.168.1.4/uk_app/' ;
  //
  // static var imageUrl = 'https://192.168.1.4/uk_app/uploads/' ;
  // static var audioUrl = 'https://192.168.1.4/uk_app/uploads/audio/' ;

  static var baseUrl = 'https://ukcdesigner.in/uk_app/android_api/';
  static var imageUrl = 'https://ukcdesigner.in/uk_app/uploads/';
  static var audioUrl = 'https://ukcdesigner.in/uk_app/uploads/audio/';
  static var pdfUrl   = "https://ukcdesigner.in/uk_app/pdf/pdf2/followup_partner_pdf.php?";
  static var excelUrl = "https://ukcdesigner.in/uk_app/excel/exp_partner_leads.php?";

  static var moviesBaseUrl = 'https://dea91516-1da3-444b-ad94-c6d0c4dfab81.mock.pstmn.io/';

  static var loginEndPint = '$baseUrl/api/login';

  static var registerApiEndPoint = '$baseUrl/api/register';

  static var moviesListEndPoint = '${moviesBaseUrl}movies_list';

  static var addLeadEndPoint = MyStaticValue.emp_type == "4"?'${baseUrl}API_partner.php':'${baseUrl}API_office.php';
  static var ajaxFollowupEndPoint = '${baseUrl}ajax_followup.php';
  static var mailEndPoint = '${baseUrl}../mail/api_mail_pass.php';

  static  changeApi()
  {
     addLeadEndPoint = MyStaticValue.emp_type == "4"?'${baseUrl}API_partner.php':'${baseUrl}API_office.php';
  }
}
