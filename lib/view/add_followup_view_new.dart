import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:partners_leads/flutter_flow/flutter_flow_theme.dart';
import 'package:partners_leads/res/app_url.dart';
import 'package:partners_leads/res/components/round_button.dart';
import 'package:partners_leads/utils/utils.dart';
import 'package:partners_leads/view_model/add_followup_view_model.dart';
import 'package:partners_leads/view_model/services/static_value.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddFollowViewNew extends StatefulWidget {
  Map<dynamic, dynamic> pdata;
  AddFollowViewNew({super.key, required this.pdata});

  @override
  State<AddFollowViewNew> createState() => _AddFollowViewNewState();
}

class _AddFollowViewNewState extends State<AddFollowViewNew> {
  // AddFollowupViewModel addFollowupViewModel = AddFollowupViewModel();
  TextEditingController meetingDate = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  String status = "Open";
  List<String> statusItem = ["Open","Interested","Not Interested", "Close", "Deal Lost"];
  String meeting = "No";
  List<String> meetingItem = ["No", "Yes", "Not Decided", "Done"];
  PlatformFile? image;
  PlatformFile? audio;
  bool callNotReceived = false;

  @override
  void dispose() {
    // addFollowupViewModel.dispose();
    meetingDate.dispose();
    dateInput.dispose();
    remarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addFollowupViewModel = Provider.of<AddFollowupViewModel>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Followup"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Status:",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    child: DropdownButtonFormField(
                      value: status,
                      items: statusItem.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (value) {
                        status = value.toString();
                      },
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Meeting with sir:",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    child: DropdownButtonFormField(
                      value: meeting,
                      items: meetingItem.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (value) {
                        meeting = value.toString();
                        if (value == "Yes") {
                          addFollowupViewModel.setMeetValue(true);
                        } else {
                          meetingDate.text = "";
                          addFollowupViewModel.setMeetValue(false);
                        }
                      },
                    ),
                  )
                ],
              ),
              ChangeNotifierProvider<AddFollowupViewModel>.value(
                  value: addFollowupViewModel,
                  child: Consumer<AddFollowupViewModel>(
                      builder: (context, value, child) {
                    return Visibility(
                      visible: value.meet,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Meeting Date: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: width * 0.5,
                            child: TextFormField(
                              controller: meetingDate,
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2030));

                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('dd-MM-yyyy')
                                          .format(pickedDate);
                                  meetingDate.text = formattedDate;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  })),
              SizedBox(
                height: height * 0.025,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Next Followup: ",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: width * 0.5,
                    child: TextFormField(
                      controller: dateInput,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030));

                        if (pickedDate != null) {
                          // print(pickedDate);
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                          // print(formattedDate);
                          dateInput.text = formattedDate;
                        } else {}
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.025,
              ),
              ChangeNotifierProvider<AddFollowupViewModel>.value(
                  value: addFollowupViewModel,
                  child: Consumer<AddFollowupViewModel>(
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Attach Audio",
                            style: TextStyle(fontSize: 18),
                          ),
                          InkWell(
                            onTap: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                      type: FileType.audio,
                                      allowMultiple: false);

                              if (result != null) {
                                audio = result.files.first;
                                addFollowupViewModel.setAudioValue(audio!.name);
                              }
                            },
                            child: Container(
                              height: 25,
                              width: width * 0.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                value.audio != "" ? value.audio : "Select File",
                                style: const TextStyle(color: Colors.blue),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                            ),
                          ),
                          Visibility(
                            visible: value.audio != "",
                            child: const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                          )
                        ],
                      );
                    },
                  )),
              SizedBox(
                height: height * 0.025,
              ),
              ChangeNotifierProvider<AddFollowupViewModel>.value(
                  value: addFollowupViewModel,
                  child: Consumer<AddFollowupViewModel>(
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Attach Image",
                            style: TextStyle(fontSize: 18),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          InkWell(
                            onTap: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                              );

                              if (result != null) {
                                image = result.files.first;
                                addFollowupViewModel.setImageValue(image!.name);
                              }
                            },
                            child: Container(
                              height: 25,
                              width: width * 0.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                value.image != "" ? value.image : "Select File",
                                style: const TextStyle(color: Colors.blue),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                            ),
                          ),
                          value.image != ""
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : const Text("")
                        ],
                      );
                    },
                  )),
              SizedBox(
                height: height * 0.025,
              ),
              const Text(
                "Remark: ",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: height * 0.025,
              ),
              TextFormField(
                controller: remarkController,
                maxLines: 2,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 01.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 01.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Theme(
                    data: ThemeData(
                      checkboxTheme: CheckboxThemeData(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      unselectedWidgetColor: Colors.blue,
                    ),
                    child: Checkbox(
                      value: callNotReceived ??= false,
                      onChanged: (newValue) async {
                        if (newValue!) {
                          dateInput.text =
                              DateFormat('dd-MM-yyyy').format(DateTime.now());
                          remarkController.text = "Call not Received";
                        } else {
                          dateInput.text = "";
                          remarkController.text = "";
                        }
                        setState(() {
                          callNotReceived = newValue!;
                        });
                      },
                      activeColor: Colors.blue,
                      checkColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                  ),
                  const Text(
                    'Call Not Received?',
                    // style: FlutterFlowTheme.of(context)
                    //     .bodyText1
                    //     .override(
                    //   fontFamily: 'Roboto',
                    //   fontWeight: FontWeight.w500,
                    // ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.025,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundButton(
                      title: "Cancel",
                      onPress: () {
                        Navigator.pop(context);
                      }),
                  RoundButton(
                    loading: addFollowupViewModel.addFollowupLoading,
                    title: "Submit",
                    onPress: () async {
                      // log( addFollowupViewModel.addFollowupLoading.toString());
                     if(remarkController.text==""){
                       Utils.flushBarErrorMessage('Please Enter Remark', context);
                     }else if (!callNotReceived)
                      {
                        if(audio==null)
                        {
                          Utils.flushBarErrorMessage('Please select Audio', context);
                        }
                      } else {
                        Map data = <String, String>{
                          "req_type": "add_followup",
                          "cid": widget.pdata['cid'],
                          "fup_by_id": MyStaticValue.id,
                          "fup_by_name": MyStaticValue.login_name,
                          // "fub_date":DateTime.now(),
                          "next_fub_date": dateInput.text,
                          "remarks": remarkController.text,
                          "status": status,
                          "meeting": meeting,
                          "meet_date": meetingDate.text,
                        };
                        //  print(data);
                        // List<MultipartFile> files = [
                        //   await http.MultipartFile.fromPath(
                        //       "audio_file", audio!.path!),
                        //   await http.MultipartFile.fromPath(
                        //       "imgpdf_file", image!.path!)
                        // ];

                        List<MultipartFile> files = [];

                        if (audio != null) {
                          if (image != null) {
                            files = [
                              await http.MultipartFile.fromPath(
                                  "audio_file", audio!.path!),
                              await http.MultipartFile.fromPath(
                                  "imgpdf_file", image!.path!)
                            ];
                          } else {
                            files = [
                              await http.MultipartFile.fromPath(
                                  "audio_file", audio!.path!)
                            ];
                          }
                        } else if (image != null) {
                          files = [
                            await http.MultipartFile.fromPath(
                                "imgpdf_file", image!.path!)
                          ];
                        }

                        addFollowupViewModel.addFollowupWithData(
                            files, data, context);
                        // asyncFileUpload(data, audio,image);}
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  asyncFileUpload(data, PlatformFile? audio, PlatformFile? image) async {
    var request =
        http.MultipartRequest("POST", Uri.parse(AppUrl.addLeadEndPoint));

    request.fields.addAll(data);

    //  var audio1 = await http.MultipartFile.fromPath("audio_file", audio!.path!);
    //  request.files.add(audio1);
    //     var image1 = await http.MultipartFile.fromPath("image_file", image!.path!);
    //  request.files.add(image1);

    List<MultipartFile> files = [
      await http.MultipartFile.fromPath("audio_file", audio!.path!),
      await http.MultipartFile.fromPath("image_file", image!.path!)
    ];
    request.files.addAll(files);
    var response = await request.send();

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }
}
