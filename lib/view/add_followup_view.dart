import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:partners_leads/res/components/drawer.dart';
import 'package:partners_leads/res/components/round_button.dart';
import 'package:partners_leads/view_model/add_followup_view_model.dart';

class AddFollowup extends StatefulWidget {
  Map<dynamic, dynamic> data;
  AddFollowup({super.key, required this.data});

  @override
  State<AddFollowup> createState() => _AddFollowupState();
}

class _AddFollowupState extends State<AddFollowup> {
  @override
  Widget build(BuildContext context) {
    TextEditingController dateInput = TextEditingController();
    TextEditingController meetingDate = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String status = "Open";
    List<String> statusitem = ['Open', "Close", "Deal Lost"];
    String meeting = "No";
    List<String> meetingitem = ["No", 'Yes', "Not Desided", "Done"];
    bool meet = false;
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text("Add Follow up"),
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
                      "Status: ",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      width: width * 0.50,
                      child: DropdownButtonFormField(
                        value: status,
                        items: statusitem.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (value) {
                          status = value.toString();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Meeting with sir",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: width * 0.50,
                      child: DropdownButtonFormField(
                        value: meeting,
                        items: meetingitem.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (value) {
                          meeting = value.toString();
                          if (value.toString() == "Yes") {
                            setState(() {
                              meet = true;
                            });
                          } else {
                            setState(() {
                              meet = false;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                Visibility(
                  visible: meet,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Meeting Date",
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
                                lastDate: DateTime.now());

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);
                              meetingDate.text = formattedDate;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Next Followup Date",
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
                              lastDate: DateTime.now());

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
                Row(
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
                        );

                        if (result != null) {
                        } else {
                          // User canceled the picker
                        }
                      },
                      child: Container(
                        height: 25,
                        width: width * 0.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                            child: Text(
                          "Select File",
                          style: TextStyle(color: Colors.blue),
                        )),
                      ),
                    ),
                    SizedBox(
                        width: width * 0.3,
                        child: const Text("value.audio.toString()"))
                  ],
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Attach Image",
                      style: TextStyle(fontSize: 18),
                    ),
                    InkWell(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.image,
                        );

                        if (result != null) {
                        } else {
                          // User canceled the picker
                        }
                      },
                      child: Container(
                        height: 25,
                        width: width * 0.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                            child: Text(
                          "Select File",
                          style: TextStyle(color: Colors.blue),
                        )),
                      ),
                    ),
                    SizedBox(
                        width: width * 0.3,
                        child: const Text("value.image.toString()"))
                  ],
                ),
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
                SizedBox(
                  height: height * 0.025,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundButton(title: "Cancel", onPress: () {}),
                    RoundButton(title: "Submit", onPress: () {}),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
