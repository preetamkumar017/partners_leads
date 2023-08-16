import 'dart:io';

import 'package:http/http.dart' as http;

_asyncFileUpload(String text, File file) async{
  
   var request = http.MultipartRequest("POST", Uri.parse("<url>"));

   request.fields["text_field"] = text;

   var pic = await http.MultipartFile.fromPath("file_field", file.path);
   
   request.files.add(pic);

   var response = await request.send();
 
  //  var responseData = await response.stream.toBytes();
  //  var responseString = String.fromCharCodes(responseData);
  //  print(responseString);
}