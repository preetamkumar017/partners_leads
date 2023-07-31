import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:partners_leads/data/response/status.dart';
import 'package:partners_leads/model/arguments.dart';
import 'package:partners_leads/res/components/drawer.dart';
import 'package:partners_leads/utils/routes/routes_name.dart';
import 'package:partners_leads/utils/utils.dart';
import 'package:partners_leads/view_model/leads_view_model.dart';
import 'package:partners_leads/view_model/services/date_formate.dart';
import 'package:partners_leads/view_model/services/filter_mobile.dart';
import 'package:partners_leads/view_model/services/static_value.dart';
import 'package:provider/provider.dart';

class DealDoneView extends StatefulWidget {
  const DealDoneView({
    super.key,
  });

  @override
  State<DealDoneView> createState() => _DealDoneViewState();
}

class _DealDoneViewState extends State<DealDoneView> {
  LeadsViewModel leadsViewModel = LeadsViewModel();

  TextEditingController dateInput = TextEditingController();
  TextEditingController dropdown = TextEditingController();
  String _patner_id = MyStaticValue.id;
  String from_date = "";
  String to_date = "";

  Map? data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = {
      'req_type': 'deal_done',
      'pid': MyStaticValue.id,
      "group_code":MyStaticValue.groupCode,
      "login_type": MyStaticValue.emp_type
    };
    print(data);
    leadsViewModel.fetchLeadsApi(data, context);
  }

  @override
  Widget build(BuildContext context) {
    BouncingScrollPhysics bouncingScrollPhysics = const BouncingScrollPhysics();
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text("Deal Done"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  leadsViewModel.fetchLeadsApi(data, context);
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
          )
        ],
      ),
      body: ChangeNotifierProvider<LeadsViewModel>.value(
          value: leadsViewModel,
          child: Consumer<LeadsViewModel>(builder: (context, value, _) {
            // print(value.leadsList.status);
            switch (value.leadsList.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Center(child: Text(value.leadsList.message.toString()));
              case Status.COMPLETED:
                return RefreshIndicator(
                  onRefresh: () => leadsViewModel.fetchLeadsApi(data, context),
                  child: ListView.builder(
                    physics: bouncingScrollPhysics,
                    itemCount: value.leadsList.data!.result!.length,
                    itemBuilder: (context, index) {
                      var result = value.leadsList.data!.result![index];

                      // print(index);
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 12),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 8, 16, 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width*0.4,
                                        child: Text(
                                          result.clientName.toString(),
                                          style: const TextStyle(
                                              fontFamily: 'Outfit',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87),
                                          overflow: TextOverflow.ellipsis,

                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                           MyMobile.lastten(result.clientMob.toString()) ,
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(10, 0, 0, 0),
                                            child: InkWell(
                                              onTap: () {
                                                // showDialog(
                                                //   context: context,
                                                //   builder:
                                                //       (BuildContext context) =>
                                                //           _seeMore(context, data),
                                                // );

                                                Map data = {
                                                  'id': result.id,
                                                  'login_id': result.loginId,
                                                  'login_name':
                                                      result.loginName,
                                                  'login_type':
                                                      result.loginType,
                                                  'is_private':
                                                      result.isPrivate,
                                                  'client_name':
                                                      result.clientName,
                                                  'client_mob':
                                                      result.clientMob,
                                                  'add_date': result.addDate,
                                                  'lead_from': result.leadFrom,
                                                  'work_detail':
                                                      result.workDetail,
                                                  'followup_by_id':
                                                      result.followupById,
                                                  'followup_by_name':
                                                      result.followupByName,
                                                  'team_work': result.teamWork,
                                                  'meeting': result.meeting,
                                                  'meet_done_date':
                                                      result.meetDoneDate,
                                                  'meet_date': result.meetDate,
                                                  'notes': result.notes,
                                                  'status': result.status,
                                                  'prev_fup_date':
                                                      result.prevFupDate,
                                                  'fup_date': result.fupDate,
                                                  'next_fup_date':
                                                      result.nextFupDate,
                                                  'last_delay_fup':
                                                      result.lastDelayFup,
                                                  'quote_req': result.quoteReq,
                                                  'quote_file':
                                                      result.quoteFile,
                                                  'create_date':
                                                      result.createDate,
                                                  'ip': result.ip,
                                                  'update_date':
                                                      result.updateDate,
                                                  'broker_id': result.brokerId,
                                                  'broker_name':
                                                      result.brokerName,
                                                  'broker_email':
                                                      result.brokerEmail,
                                                  'new_emp_id': result.newEmpId,
                                                  'member_code':
                                                      result.memberCode,
                                                  'plot_size': result.plotSize,
                                                  'size_type': result.sizeType,
                                                  'location': result.location,
                                                  'deal_done_date':
                                                      result.dealDoneDate,
                                                  'employee_name':
                                                      result.employeeName,
                                                };
                                                Navigator.pushNamed(context,
                                                    RoutesName.followupDetails,
                                                    arguments:
                                                        ScreenArguments(data));
                                              },
                                              child: const Icon(
                                                Icons.info_outlined,
                                                size: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("C. Partner:${result.brokerName}"),
                                      Text("Date: ${MyDateFormate.ddMMMyyyy(result.addDate) }")
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 10, 0, 0),
                                        child: Text(
                                          'Plot Size: ${result.plotSize}',
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.image_outlined,
                                            size: 24,
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 0, 0, 0),
                                            child: Icon(
                                              Icons.audiotrack,
                                              size: 24,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(20, 0, 0, 0),
                                            child: InkWell(
                                              onTap: () {
                                                Map data = {
                                                  'cid': result.id,
                                                };
                                                Navigator.pushNamed(context, RoutesName.addFollowupnew,arguments: ScreenArguments(data));
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 8),
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: const AlignmentDirectional(
                                              -1, -1),
                                          child: Text(
                                            'Note: ${result.notes}',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutesName.createLeads);
        },
        child: const Icon(Icons.add),
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
                    items: value.leadsList.data?.partnerNameId!.map(
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
                      Utils.flushBarErrorMessage(_patner_id, context);
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
              'req_type': 'deal_done',
              'pid': _patner_id,
              'from_date': from_date,
              'to_date': to_date,
              "login_type": MyStaticValue.emp_type
            };

            leadsViewModel.fetchLeadsApi(data, context);
            Navigator.of(context).pop();
            // Navigator.pop(context);
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
