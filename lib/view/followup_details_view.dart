import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:partners_leads/data/response/status.dart';
import 'package:partners_leads/model/arguments.dart';
import 'package:partners_leads/res/app_url.dart';
import 'package:partners_leads/res/components/my_alert.dart';
import 'package:partners_leads/utils/routes/routes_name.dart';
import 'package:partners_leads/view_model/leads_view_model.dart';
import 'package:partners_leads/view_model/services/date_formate.dart';
import 'package:partners_leads/view_model/services/filter_mobile.dart';
import 'package:partners_leads/view_model/services/static_value.dart';
import 'package:provider/provider.dart';

class FollowupDetails extends StatefulWidget {
  Map<dynamic, dynamic> data;
  FollowupDetails({super.key, required this.data});

  @override
  State<FollowupDetails> createState() => _FollowupDetailsState();
}

class _FollowupDetailsState extends State<FollowupDetails> {
  LeadsViewModel leadsViewModel = LeadsViewModel();
  @override
  void initState() {
    super.initState();
    var lead_type = "public";
    var emptype = "1";
    var type = "load_modal";
    Map post_data = {
      'req_type': type,
      'id': widget.data['id'],
      'lead_type': lead_type,
      'emptype': MyStaticValue.emp_type,
    };
    print(post_data);

    leadsViewModel.fetchFollowupDetailsApi(post_data, context);
  }

  @override
  Widget build(BuildContext context) {
    // if (kDebugMode) {
    //   print(widget.data);
    // }

    var size = MediaQuery.of(context).size;
    var height = size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Followup Details"),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(12, 16, 12, 12),
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person),
                        Text(
                          widget.data['client_name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Outfit',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: InkWell(
                        onTap: () {
                          MyAlert.myCallAlert(context,MyMobile.lastten(widget.data['client_mob']));
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: IconTheme(
                                  data: Theme.of(context).primaryIconTheme,
                                  child: const Icon(Icons.phone)),
                            ),
                            Text(
                              MyStaticValue.emp_type != 6
                                  ? widget.data['client_mob']
                                  : "XXXXXXXXXX",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: Text(
                    'C. Partner: ${widget.data['broker_name']}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: Text(
                    'Create date: ' +
                        MyDateFormate.ddMMMyyyy(widget.data['create_date']),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Followup By:-${widget.data['followup_by_name']}',
                      ),
                      // Text(
                      //   'Lead From:- ${widget.data['lead_from']}',
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Status:  ${widget.data['status']}',
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Meeting Sir: ${widget.data['meeting']}',
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 0, 0, 0),
                            child: (widget.data['imgpdfFile'] != "")
                                ? InkWell(
                                    onTap: () {
                                      Map arg = {
                                        "image": "${AppUrl.imageUrl}" +
                                            widget.data['imgpdfFile']
                                      };
                                      Navigator.of(context).pushNamed(
                                          RoutesName.image_viewer,
                                          arguments: ScreenArguments(arg));
                                    },
                                    child: const Icon(
                                      Icons.image_outlined,
                                      size: 24,
                                    ),
                                  )
                                : Tooltip(
                                    preferBelow: false,
                                    triggerMode: TooltipTriggerMode.tap,
                                    message: "Image not available",
                                    child: IconTheme(
                                      data: Theme.of(context).iconTheme,
                                      child: const Icon(
                                          Icons.image_not_supported_outlined),
                                    )),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10, 0, 10, 0),
                            child: (widget.data['audioFile'] != "")
                                ? InkWell(
                                    onTap: () {
                                      Map arg = {
                                        "audio":
                                            "${AppUrl.audioUrl}${widget.data['audioFile']}"
                                      };
                                      Navigator.of(context).pushNamed(
                                          RoutesName.audio_player,
                                          arguments: ScreenArguments(arg));
                                    },
                                    child: const Icon(
                                      Icons.music_note,
                                      size: 24,
                                    ),
                                  )
                                : Tooltip(
                                    preferBelow: false,
                                    triggerMode: TooltipTriggerMode.tap,
                                    message: "Audio not available",
                                    child: IconTheme(
                                        data: Theme.of(context).iconTheme,
                                        child:
                                            const Icon(Icons.music_off_sharp))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Meeting Date:- ${MyDateFormate.ddMMMyyyy(widget.data['meet_date'])}',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Work Details:-  ${widget.data['work_detail']}',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 10, 0),
                  child: Text(
                    'Notes:- ${widget.data['notes']}',
                    softWrap: false,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            const Divider(
              thickness: 2.0,
              color: Color.fromARGB(53, 84, 19, 141),
            ),
            ChangeNotifierProvider<LeadsViewModel>(
              create: (context) => leadsViewModel,
              child: Consumer<LeadsViewModel>(
                builder: (context, value, _) {
                  switch (value.followup_details_model.status) {
                    case Status.LOADING:
                      return const Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return Center(
                          child: Text(
                              value.followup_details_model.message.toString()));
                    case Status.COMPLETED:
                      // print(value.labourList.data!.labourList!.length
                      //     .toString());

                      return Expanded(
                        child: SizedBox(
                          height: height,
                          child: ListView.builder(
                              itemCount: value
                                  .followup_details_model.data!.data!.length,
                              itemBuilder: (context, index) {
                                var data = value
                                    .followup_details_model.data!.data![index];
                                return Card(
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Follow By: ${data.fupByName}',
                                            ),
                                            Text(MyDateFormate.ddMMMyyyy(
                                                data.fupDate!)),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  'File:',
                                                ),
                                                Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                            10, 0, 10, 0),
                                                    child: data.imgpdfFile != ""
                                                        ? InkWell(
                                                            onTap: () {
                                                              Map arg = {
                                                                "image":
                                                                    "${AppUrl.imageUrl}${data.imgpdfFile}"
                                                              };
                                                              Navigator.of(
                                                                      context)
                                                                  .pushNamed(
                                                                      RoutesName
                                                                          .image_viewer,
                                                                      arguments:
                                                                          ScreenArguments(
                                                                              arg));
                                                            },
                                                            child: const Icon(
                                                              Icons.image,
                                                              size: 20,
                                                            ),
                                                          )
                                                        : Tooltip(
                                                            preferBelow: false,
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
                                                                      .image_not_supported_outlined),
                                                            ))),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(5, 0, 0, 0),
                                                  child: data.audioFile != ""
                                                      ? InkWell(
                                                          onTap: () {
                                                            Map arg = {
                                                              "audio":
                                                                  "${AppUrl.audioUrl}${data.audioFile!}"
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
                                                            size: 20,
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
                                                            child: const Icon(Icons
                                                                .music_off_sharp),
                                                          )),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 0),
                                              child: Text(
                                                'Next Date: ${MyDateFormate.ddMMMyyyy(data.nextFupDate!)}',
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Remark:  ${data.remarks}',
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      );

                    default:
                      break;
                  }
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
