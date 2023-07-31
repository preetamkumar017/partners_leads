import 'dart:developer';
import 'dart:io';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:partners_leads/data/response/status.dart';
import 'package:partners_leads/model/arguments.dart';
import 'package:partners_leads/model/leads_with_group_model.dart';
import 'package:partners_leads/res/app_url.dart';
import 'package:partners_leads/res/components/drawer.dart';
import 'package:partners_leads/res/components/my_alert.dart';
import 'package:partners_leads/utils/routes/routes_name.dart';
import 'package:partners_leads/utils/utils.dart';
import 'package:partners_leads/view_model/create_leads_view_model.dart';
import 'package:partners_leads/view_model/leads_view_model.dart';
import 'package:partners_leads/view_model/services/date_formate.dart';
import 'package:partners_leads/view_model/services/filter_mobile.dart';
import 'package:partners_leads/view_model/services/static_value.dart';
import 'package:provider/provider.dart';

class GroupList extends StatefulWidget {
  Map arg_data;
  GroupList({super.key, required this.arg_data});

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  LeadsViewModel leadsViewModel = LeadsViewModel();
  CreateLeadsViewModel deleteViewModel = CreateLeadsViewModel();
  TextEditingController dateInput = TextEditingController();
  TextEditingController searchInput = TextEditingController();
  String _patner_id = MyStaticValue.id;
  String from_date = "";
  String to_date = "";
  String rangeDate = "";

  var serchData = "";

  Map? data;
  @override
  void initState() {
    super.initState();

    if (MyStaticValue.emp_type == "1" ||
        MyStaticValue.emp_type == "2" ||
        MyStaticValue.emp_type == "6") {
      data = {
        'req_type': 'group_leads',
        'partner_group': widget.arg_data['group'],
        "login_type": MyStaticValue.emp_type,
        "group_code":MyStaticValue.groupCode
      };
    } else {
      data = {
        'req_type': 'group_leads',
        'pid': MyStaticValue.id,
        'partner_group': widget.arg_data['group'],
        "login_type": MyStaticValue.emp_type,
        "group_code":MyStaticValue.groupCode
      };
    }

    leadsViewModel.fetchLeadsWithGroupApi(data, context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BouncingScrollPhysics bouncingScrollPhysics = const BouncingScrollPhysics();
    // print(MyStaticValue.emp_type);
    return LoaderOverlay(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: const MyDrawer(),
        appBar: AppBar(
          title: const Text("Group List"),
          centerTitle: false,
          actions: [
            const Center(child: Text("Filter")),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    leadsViewModel.fetchLeadsWithGroupApi(data, context);
                  },
                  child: const Icon(Icons.filter_alt_off)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => _filter(context),
                    );
                  },
                  child: const Icon(Icons.filter_list_alt)),
            ),
            PopupMenuButton(
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text("Download Excel"),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text("Download PDF"),
                ),
              ];
            }, onSelected: (value) async {
              if (value == 0) {
                // print("My account menu is selected.");
              } else if (value == 1) {
                Utils.flushBarInfoMessage(
                    "Please wait File downloading...", context);
                if (from_date != "" && to_date != "") {
                  rangeDate =
                      "${from_date.replaceAll('-', '/')} - ${to_date.replaceAll('-', '/')}";
                }
                // log("${AppUrl.excelUrl}cid=${MyStaticValue.id}&daterange=$rangeDate");
                openFile(
                    url:
                        "${AppUrl.excelUrl}cid=${MyStaticValue.id}&daterange=$rangeDate",
                    fileName:
                        'UKC-Cost-Calculation-${DateTime.now().millisecondsSinceEpoch.toString()}.xlsx');
                // print("Settings menu is selected.");
              } else if (value == 2) {
                Utils.flushBarInfoMessage(
                    "Please wait File downloading...", context);
                if (from_date != "" && to_date != "") {
                  rangeDate =
                      "${from_date.replaceAll('-', '/')} - ${to_date.replaceAll('-', '/')}";
                }

                // log("${AppUrl.pdfUrl}cid=${MyStaticValue.id}&daterange=$rangeDate");

                openFile(
                    url:
                        "${AppUrl.pdfUrl}cid=${MyStaticValue.id}&daterange=$rangeDate",
                    fileName:
                        'UKC-Cost-Calculation-${DateTime.now().millisecondsSinceEpoch.toString()}.pdf');
              }
            }),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: searchInput,
                        onChanged: (value) {
                          serchData = value;
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          // prefixIcon: const Icon(Icons.search),
                          hintText: "Search here...",
                          suffixIcon: IconButton(
                              onPressed: () {
                                searchInput.text = "";
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Theme.of(context).primaryColor,
                              )),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1, //<-- SEE HERE
                              color: Theme.of(context).primaryColorLight,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1, //<-- SEE HERE
                              color: Theme.of(context).primaryColorLight,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1, //<-- SEE HERE
                              color: Theme.of(context).primaryColorLight,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ChangeNotifierProvider<LeadsViewModel>.value(
                    value: leadsViewModel,
                    child:
                        Consumer<LeadsViewModel>(builder: (context, value, _) {
                      switch (value.leadsWithGroupList.status) {
                        case Status.LOADING:
                          return const Center(
                              child: CircularProgressIndicator());
                        case Status.ERROR:
                          return Center(
                              child: Text(
                                  value.leadsWithGroupList.message.toString()));
                        case Status.COMPLETED:
                          var data0 = value.leadsWithGroupList.data!.result;
                          return RefreshIndicator(
                            onRefresh: () => leadsViewModel
                                .fetchLeadsWithGroupApi(data, context),
                            child: ListView.builder(
                              physics: bouncingScrollPhysics,
                              itemCount: data0!
                                  .where((element) => element.clientName!
                                      .toLowerCase()
                                      .contains(searchInput.text.toLowerCase()))
                                  .length,
                              itemBuilder: (context, index) {
                                Result result = data0[index];
                                try {
                                  result = data0
                                      .where((element) => element.clientName!
                                          .toLowerCase()
                                          .contains(
                                              searchInput.text.toLowerCase()))
                                      .toList()[index];
                                } catch (e) {
                                  print(e);
                                }

                                Map data = result.toJson();

                                //
                                // Map data = {
                                //   'id': result.id,
                                //   'login_id': result.loginId,
                                //   'login_name': result.loginName,
                                //   'login_type': result.loginType,
                                //   'is_private': result.isPrivate,
                                //   'client_name': result.clientName,
                                //   'client_mob': result.clientMob,
                                //   'add_date': result.addDate,
                                //   'lead_from': result.leadFrom,
                                //   'work_detail': result.workDetail,
                                //   'followup_by_id': result.followupById,
                                //   'followup_by_name': result.followupByName,
                                //   'team_work': result.teamWork,
                                //   'meeting': result.meeting,
                                //   'meet_done_date': result.meetDoneDate,
                                //   'meet_date': result.meetDate,
                                //   'notes': result.notes,
                                //   'status': result.status,
                                //   'prev_fup_date': result.prevFupDate,
                                //   'fup_date': result.fupDate,
                                //   'next_fup_date': result.nextFupDate,
                                //   'last_delay_fup': result.lastDelayFup,
                                //   'quote_req': result.quoteReq,
                                //   'quote_file': result.quoteFile,
                                //   'create_date': result.createDate,
                                //   'ip': result.ip,
                                //   'update_date': result.updateDate,
                                //   'broker_id': result.brokerId,
                                //   'broker_name': result.brokerName,
                                //   'broker_email': result.brokerEmail,
                                //   'new_emp_id': result.newEmpId,
                                //   'member_code': result.memberCode,
                                //   'plot_size': result.plotSize,
                                //   'size_type': result.sizeType,
                                //   'location': result.location,
                                //   'deal_done_date': result.dealDoneDate,
                                //   'employee_name': result.employeeName,
                                //   'imgpdfFile': result.imgpdfFile,
                                //   'audioFile': result.audioFile,
                                // };


                                return Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12, 12, 12, 12),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 7,
                                          color: Color(0x2F1D2429),
                                          offset: Offset(0, 3),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 12),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 8, 16, 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 8.0),
                                                      child: Icon(
                                                        Icons.person,
                                                        size: 18,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.30,
                                                      child: Text(
                                                        "${result.clientName}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'Outfit',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                Colors.black87),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        MyAlert.myCallAlert(
                                                            context,
                                                            MyMobile.lastten(
                                                                result.clientMob
                                                                    .toString()));
                                                      },
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.phone,
                                                            size: 18,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 3.0),
                                                            child: Text(
                                                              MyStaticValue
                                                                          .emp_type !=
                                                                      6
                                                                  ? MyMobile.lastten(result
                                                                      .clientMob
                                                                      .toString())
                                                                  : "XXXXXXXXXX",
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    MyStaticValue.emp_type !=
                                                            "6"
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                    10,
                                                                    0,
                                                                    0,
                                                                    0),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                Navigator.of(context).pushNamed(
                                                                    RoutesName
                                                                        .editLeads,
                                                                    arguments:
                                                                        ScreenArguments(
                                                                            data));
                                                              },
                                                              child: const Icon(
                                                                Icons.edit,
                                                                size: 22,
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                                    (MyStaticValue.emp_type ==
                                                                "1" ||
                                                            MyStaticValue
                                                                    .emp_type ==
                                                                "8")
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                    10,
                                                                    0,
                                                                    0,
                                                                    0),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                Map deldata = {
                                                                  'req_type':
                                                                      'delete_client',
                                                                  'id':
                                                                      result.id,
                                                                };
                                                                myDeleteAlert(
                                                                    context,
                                                                    deldata);
                                                              },
                                                              child: const Icon(
                                                                Icons.delete,
                                                                size: 22,
                                                                color: Color
                                                                    .fromARGB(
                                                                        129,
                                                                        244,
                                                                        67,
                                                                        54),
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 0, 16, 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "C. Partner: ${result.brokerName}"),
                                                Text(
                                                    "Date: ${MyDateFormate.ddMMMyyyy(result.addDate.toString())}")
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 0, 16, 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            -1, -1),
                                                    child: Text(
                                                      'Status: ${result.status}',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 0, 16, 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Plot Size: ${result.plotSize} ${result.sizeType}',
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    20.0),
                                                        child: result
                                                                    .imgpdfFile !=
                                                                ""
                                                            ? InkWell(
                                                                onTap: () {
                                                                  Map data = {
                                                                    "image":
                                                                        "${AppUrl.imageUrl}${result.imgpdfFile}"
                                                                  };
                                                                  Navigator.of(context).pushNamed(
                                                                      RoutesName
                                                                          .image_viewer,
                                                                      arguments:
                                                                          ScreenArguments(
                                                                              data));
                                                                },
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .image_outlined,
                                                                  size: 24,
                                                                ),
                                                              )
                                                            : Tooltip(
                                                                preferBelow:
                                                                    false,
                                                                triggerMode:
                                                                    TooltipTriggerMode
                                                                        .tap,
                                                                message:
                                                                    "Image not available",
                                                                child: IconTheme(
                                                                    data: Theme.of(
                                                                            context)
                                                                        .iconTheme,
                                                                    child: const Icon(
                                                                        Icons
                                                                            .image_not_supported_outlined)))),
                                                    result.audioFile != ""
                                                        ? InkWell(
                                                            onTap: () {
                                                              Map arg = {
                                                                "audio":
                                                                    "${AppUrl.audioUrl}${result.audioFile}"
                                                              };
                                                              Navigator.of(
                                                                      context)
                                                                  .pushNamed(
                                                                      RoutesName
                                                                          .audio_player,
                                                                      arguments:
                                                                          ScreenArguments(
                                                                              arg));
                                                            },
                                                            child: const Icon(
                                                              Icons.music_note,
                                                              size: 24,
                                                            ),
                                                          )
                                                        : Tooltip(
                                                            preferBelow: false,
                                                            triggerMode:
                                                                TooltipTriggerMode
                                                                    .tap,
                                                            message:
                                                                "Audio not available",
                                                            child: IconTheme(
                                                                data: Theme.of(
                                                                        context)
                                                                    .iconTheme,
                                                                child: const Icon(
                                                                    Icons
                                                                        .music_off_sharp))),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                              20, 0, 0, 0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Map data = {
                                                            'cid': result.id,
                                                          };
                                                          Navigator.pushNamed(
                                                              context,
                                                              RoutesName
                                                                  .addFollowupnew,
                                                              arguments:
                                                                  ScreenArguments(
                                                                      data));
                                                        },
                                                        child: const Icon(
                                                          Icons.person_add_alt,
                                                          size: 24,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 0, 16, 8),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    'Work Details: ${result.workDetail}',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 0, 16, 4),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            -1, -1),
                                                    child: Text(
                                                      'Note: ${result.notes}',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 18.0),
                                                child: Text(
                                                  "Next Followup: ${MyDateFormate.ddMMMyyyy(result.nextFupDate)}",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme.secondary),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          RoutesName
                                                              .followupDetails,
                                                          arguments:
                                                              ScreenArguments(
                                                                  data));
                                                    },
                                                    child: Text(
                                                      "See More",
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme.secondary),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(
                                                      Icons.arrow_forward_sharp,
                                                      color: Theme.of(context)
                                                          .colorScheme.secondary,
                                                      size: 15,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );

                              },
                            ),
                          );
                        default:
                          break;
                      }
                      return Container();
                    })),
              ),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   tooltip: "Add Leads",
        //   onPressed: () async {
        //     if (MyStaticValue.valid || (MyStaticValue.emp_type != 4)) {
        //       await Navigator.pushNamed(context, RoutesName.createLeads);
        //       leadsViewModel.fetchLeadsWithGroupApi(data, context);
        //     } else {
        //       Utils.flushBarErrorMessageForAddClient(
        //           "Your 6 month subscription plan has been Expired", context);
        //     }
        //   },
        //   child: const Icon(Icons.add),
        // ),
      ),
    );
  }

  Widget _filter(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: dateInput,
            decoration: const InputDecoration(
                focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(width: 2)),
                enabledBorder:
                    OutlineInputBorder(borderSide: BorderSide(width: 2)),
                hintText: "Select Date",
                hintStyle: TextStyle()),
            readOnly: true,
            onTap: () async {
              DateTimeRange? pickedDate = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2021),
                  lastDate: DateTime.now());

              if (pickedDate != null) {
                // String formattedDate =
                //     DateFormat('dd-MM-yyyy').format(pickedDate);
                // dateInput.text = pickedDate.toString();
                from_date = DateFormat('dd-MM-yyyy').format(pickedDate.start);
                to_date = DateFormat('dd-MM-yyyy').format(pickedDate.end);
                dateInput.text = "$from_date - $to_date";
                log(dateInput.text);
              } else {}
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ChangeNotifierProvider<LeadsViewModel>.value(
              value: leadsViewModel,
              child: Consumer<LeadsViewModel>(builder: (context, value, _) {
                if (MyStaticValue.emp_type == "1" ||
                    MyStaticValue.emp_type == '2') {
                  return DropdownButtonFormField(
                    hint: const Text("--Select--", style: TextStyle()),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    ),
                    items: value.leadsWithGroupList.data?.partnerNameId!.map(
                      (e) {
                        return DropdownMenuItem(
                            value: e.id,
                            child: Text(
                              e.employeeName.toString(),
                            ));
                      },
                    ).toList(),
                    onChanged: ((value) {
                      _patner_id = value.toString();
                      // Utils.flushBarErrorMessage(_patner_id, context);
                    }),
                  );
                } else {
                  return const SizedBox();
                }
              }))
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_patner_id.isEmpty) {
              _patner_id = "";
            }
            if (from_date.isEmpty) {
              from_date = "";
              to_date = "";
            }
            Map data = {
              'req_type': 'get_leads',
              'pid': _patner_id,
              'from_date': from_date,
              'to_date': to_date,
              "login_type": MyStaticValue.emp_type
            };
            print(data);

            leadsViewModel.fetchLeadsWithGroupApi(data, context);
            Navigator.of(context).pop();
            // Navigator.pop(context);
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  myDeleteAlert(BuildContext context, delData) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Please confirm '),
        content: const Text('Make sure Do you want to Delete'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await deleteViewModel.deleteClientApi(delData, context);
              leadsViewModel.fetchLeadsWithGroupApi(data, context);
              // Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future openFile({required String url, String? fileName}) async {
    final file = await downloadFile(url, fileName!);
    if (file == null) return;

    log('Path: ${file.path}');
    Utils.toastMessage("Successfully downloaded to: ${file.path}");

    // OpenFile.open(file.path);
    // OpenFile.open(file.path);
  }

  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await AndroidPathProvider.downloadsPath;
    final file = File('${appStorage}/$name');
    try {
      final response = await Dio().get(url,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0));

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (e) {
      return null;
    }
  }
}
