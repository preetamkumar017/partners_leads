import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:partners_leads/res/components/drawer.dart';
import 'package:partners_leads/res/components/round_button.dart';
import 'package:partners_leads/utils/utils.dart';
import 'package:partners_leads/view_model/create_leads_view_model.dart';
import 'package:partners_leads/view_model/services/filter_mobile.dart';
import 'package:partners_leads/view_model/services/static_value.dart';
import 'package:provider/provider.dart';

class CreateLeads extends StatefulWidget {
  const CreateLeads({super.key});

  @override
  State<CreateLeads> createState() => _CreateLeadsState();
}

class _CreateLeadsState extends State<CreateLeads> {
  final TextEditingController _client_name = TextEditingController();
  final TextEditingController _mobile_number = TextEditingController();
  final TextEditingController _work_details = TextEditingController();
  final TextEditingController _plot_size = TextEditingController();
  final TextEditingController _note = TextEditingController();

  FocusNode client_nameFocusNode = FocusNode();
  FocusNode mobile_numberFocusNode = FocusNode();
  FocusNode work_detailsFocusNode = FocusNode();
  FocusNode plot_sizeFocusNode = FocusNode();
  FocusNode noteFocusNode = FocusNode();

  final FlutterContactPicker _contactPicker = FlutterContactPicker();
  PlatformFile? image;
  PlatformFile? audio;

  @override
  void dispose() {
    super.dispose();
    client_nameFocusNode.dispose();
    mobile_numberFocusNode.dispose();
    work_detailsFocusNode.dispose();
    plot_sizeFocusNode.dispose();
    noteFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    final createLeadsViewMode = Provider.of<CreateLeadsViewModel>(context);
    String size = "sqft";
    List<String> sizeitem = ['sqft', "sqm"];
    String status = "Open";
    List<String> statusitem = ["Open","Interested","Not Interested", "Done", "Close", "Deal Lost"];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text("Create Lead"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: const [
                  Icon(Icons.list_alt),
                  Text(" List"),
                ],
              ),
            )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                TextFormField(
                  controller: _client_name,
                  keyboardType: TextInputType.text,
                  focusNode: client_nameFocusNode,
                  decoration: const InputDecoration(
                      hintText: 'Client Name',
                      labelText: 'Client Name',
                      prefixIcon: Icon(Icons.account_circle)),
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                        context, client_nameFocusNode, mobile_numberFocusNode);
                  },
                ),
                TextFormField(
                  controller: _mobile_number,
                  keyboardType: TextInputType.phone,
                  focusNode: mobile_numberFocusNode,
                  decoration: InputDecoration(
                      hintText: 'Mobile Number',
                      labelText: 'Mobile Number',
                      prefixIcon: const Icon(Icons.mobile_friendly),
                      suffixIcon: InkWell(
                          onTap: () async {
                            Contact? contact =
                                await _contactPicker.selectContact();
                            setState(() {
                              String s = contact.toString();

                              s = s.substring(s.indexOf("[") + 1);
                              s = s.substring(0, s.indexOf("]"));
                              _mobile_number.text = s;//MyMobile.lastten(s);
                            });
                          },
                          child: const Icon(Icons.contact_phone))),
                  onFieldSubmitted: (valu) {
                    Utils.fieldFocusChange(
                        context, mobile_numberFocusNode, work_detailsFocusNode);
                  },
                ),
                TextFormField(
                  controller: _work_details,
                  keyboardType: TextInputType.text,
                  focusNode: work_detailsFocusNode,
                  decoration: const InputDecoration(
                      hintText: 'Work Details',
                      labelText: 'Work Details',
                      prefixIcon: Icon(Icons.business_center)),
                  onFieldSubmitted: (valu) {
                    Utils.fieldFocusChange(
                        context, work_detailsFocusNode, plot_sizeFocusNode);
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _plot_size,
                        keyboardType: TextInputType.number,
                        focusNode: plot_sizeFocusNode,
                        decoration: const InputDecoration(
                            hintText: 'Plot Size',
                            labelText: 'Plot Size',
                            prefixIcon: Icon(Icons.photo_size_select_small)),
                        onFieldSubmitted: (valu) {
                          Utils.fieldFocusChange(
                              context, plot_sizeFocusNode, noteFocusNode);
                        },
                      ),
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: size,
                        items: sizeitem.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (value) {
                          size = value.toString();
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(
                        child: Text(
                      "Status: ",
                      style: TextStyle(fontSize: 20),
                    )),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: status,
                        items: statusitem.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (value) {
                          size = value.toString();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                ChangeNotifierProvider<CreateLeadsViewModel>.value(
                    value: createLeadsViewMode,
                    child: Consumer<CreateLeadsViewModel>(
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
                                  createLeadsViewMode.setAudioValue(audio!.name);
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
                            value.audio != ""
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
                ChangeNotifierProvider<CreateLeadsViewModel>.value(
                    value: createLeadsViewMode,
                    child: Consumer<CreateLeadsViewModel>(
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
                                  createLeadsViewMode.setImageValue(image!.name);
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
                TextFormField(
                  controller: _note,
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  focusNode: noteFocusNode,
                  decoration: const InputDecoration(
                      hintText: 'Note',
                      labelText: 'Note',
                      prefixIcon: Icon(Icons.note_outlined)),
                  onFieldSubmitted: (valu) {
                    Utils.fieldFocusChange(context, noteFocusNode, noteFocusNode);
                  },
                ),
                SizedBox(
                  height: height * .085,
                ),
                RoundButton(
                  title: 'Submit',
                  loading: createLeadsViewMode.loading,
                  onPress: () async {
                    if (_client_name.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          'Please enter Client Name', context);
                    } else if (_mobile_number.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          'Please enter Mobile Number', context);
                    } else if (_mobile_number.text.length < 10 ) {
                      Fluttertoast.showToast(msg: _mobile_number.text.length.toString());
                      Utils.flushBarErrorMessage('Please enter valid Mobile Number', context);
                    } else if (_work_details.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          'Please enter Work Details', context);
                    } else if (_plot_size.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          'Please enter Plot Size', context);
                    } else if (_note.text.isEmpty) {
                      Utils.flushBarErrorMessage('Please enter note', context);
                    }
                    // else if (audio==null) {
                    // Utils.flushBarErrorMessage('Please Select Audio', context);
                    // }
                    else {
                      Map<String, String> data = {
                        'req_type': "add_client",
                        'client_name': _client_name.text,
                        'client_mob': _mobile_number.text,
                        'work_detail': _work_details.text,
                        'plot_size': _plot_size.text,
                        'size_type': size,
                        'notes': _note.text,
                        'login_id': MyStaticValue.id,
                        'login_name': MyStaticValue.login_name,
                        'login_type': MyStaticValue.emp_type,
                        'member_code': MyStaticValue.memberCode,
                        'status': "Open",
                      };

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
                      createLeadsViewMode.createLeads(files, data, context);
                    }
                  },
                ),
                SizedBox(
                  height: height * .02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
