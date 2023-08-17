import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:partners_leads/data/response/status.dart';
import 'package:partners_leads/model/QuickCalcListModel.dart';
import 'package:partners_leads/res/components/common.dart';
import 'package:partners_leads/utils/routes/routes_name.dart';
import 'package:partners_leads/view_model/quick_calc_view_model.dart';
import 'package:styled_divider/styled_divider.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class QuickCalculationListView extends StatefulWidget {
  const QuickCalculationListView({Key? key}) : super(key: key);

  @override
  _QuickCalculationListViewState createState() =>
      _QuickCalculationListViewState();
}

class _QuickCalculationListViewState extends State<QuickCalculationListView> with TickerProviderStateMixin{

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final qc = Get.put(QuickCalcController());
  late AnimationController controller;

  @override
  void initState() {
    qc.calcListData();
    controller = BottomSheet.createAnimationController(this);
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
          child: Column(
            // padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.arrow_back_sharp,
                      color: FlutterFlowTheme.of(context).iconColor,
                      size: 24,
                    ),
                    Expanded(
                      child: Text(
                        'Quick Calculation List',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).headlineSmall,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Obx(() {
                    switch (qc.getStatus) {
                      case Status.LOADING:
                        return const Center(child: CircularProgressIndicator());
                      case Status.ERROR:
                        return const Center(child: Text("Something Went Wrong"));
                      case Status.EMPTY:
                        return const Center(child: Text("Data not Found"));
                      case Status.COMPLETED:
                        return RefreshIndicator(
                          onRefresh:() async{

                            qc.calcListData();
                          },
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: qc.getCalcList.records!.length,
                              itemBuilder:(context, index) {
                                Records data = qc.getCalcList.records![index];
                                int area = int.parse(data.length ?? "0") * int.parse(data.width ?? "0");
                                return  Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                                  child: InkWell(
                                    onLongPress: () {
                                      change(data.id ?? "0",data);
                                    },
                                    onTap: () {

                                      Navigator.pushNamed(context, RoutesName.quickCalcDetails,arguments: data);
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 3,
                                            color: FlutterFlowTheme.of(context).shadowcolor,
                                            offset: const Offset(0, 2),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context).bordercolor2,
                                          width: 2,
                                        ),
                                      ),
                                      child: Padding(
                                        padding:
                                        const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsetsDirectional.fromSTEB(
                                                            0, 0, 8, 0),
                                                        child: Container(
                                                          width: 20,
                                                          height: 20,
                                                          decoration: BoxDecoration(
                                                            color:
                                                            FlutterFlowTheme.of(context)
                                                                .iconbackground,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Icon(
                                                            Icons.call,
                                                            color:
                                                            FlutterFlowTheme.of(context)
                                                                .primary,
                                                            size: 15,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        data.mobile ?? "",
                                                        textAlign: TextAlign.start,
                                                        style: FlutterFlowTheme.of(context)
                                                            .labelMedium,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsetsDirectional.fromSTEB(
                                                            0, 0, 10, 0),
                                                        child: Text(
                                                          '$area Sqft.',
                                                          textAlign: TextAlign.start,
                                                          style: FlutterFlowTheme.of(context)
                                                              .labelMedium,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsetsDirectional.fromSTEB(
                                                            0, 0, 8, 0),
                                                        child: Container(
                                                          width: 20,
                                                          height: 20,
                                                          decoration: BoxDecoration(
                                                            color:
                                                            FlutterFlowTheme.of(context)
                                                                .iconbackground,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Icon(
                                                            Icons.home_filled,
                                                            color:
                                                            FlutterFlowTheme.of(context)
                                                                .primary,
                                                            size: 15,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsetsDirectional.fromSTEB(
                                                            0, 0, 8, 0),
                                                        child: Container(
                                                          width: 20,
                                                          height: 20,
                                                          decoration: BoxDecoration(
                                                            color:
                                                            FlutterFlowTheme.of(context)
                                                                .iconbackground,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Icon(
                                                            Icons.stairs_outlined,
                                                            color:
                                                            FlutterFlowTheme.of(context)
                                                                .primary,
                                                            size: 15,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        '${data.floor}th FLoor',
                                                        textAlign: TextAlign.start,
                                                        style: FlutterFlowTheme.of(context)
                                                            .labelMedium,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsetsDirectional.fromSTEB(
                                                            0, 0, 10, 0),
                                                        child: Text(
                                                          'Rs. ${formatNumber(double.parse(data.rate ?? "0"))}',
                                                          textAlign: TextAlign.start,
                                                          style: FlutterFlowTheme.of(context)
                                                              .labelMedium,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsetsDirectional.fromSTEB(
                                                            0, 0, 8, 0),
                                                        child: Container(
                                                          width: 20,
                                                          height: 20,
                                                          decoration: BoxDecoration(
                                                            color:
                                                            FlutterFlowTheme.of(context)
                                                                .iconbackground,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Icon(
                                                            Icons.person,
                                                            color:
                                                            FlutterFlowTheme.of(context)
                                                                .primary,
                                                            size: 15,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            StyledDivider(
                                              thickness: 1,
                                              color:
                                              FlutterFlowTheme.of(context).dividercolor,
                                              lineStyle: DividerLineStyle.dashed,
                                            ),
                                            Align(
                                              alignment: const AlignmentDirectional(1, 0),
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Estimate Cost:   ',
                                                      style: FlutterFlowTheme.of(context)
                                                          .displayLarge
                                                          .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: 'Rs. ${formatNumber(double.parse(data.projectCost ?? "0"))}',
                                                      style: FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16,
                                                      ),
                                                    )
                                                  ],
                                                  style:
                                                  FlutterFlowTheme.of(context).bodyMedium,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }, ),
                        );
                      default:
                        return Container();
                    }
                  }),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
         await Navigator.pushNamed(context, RoutesName.quickCalc);
          qc.calcListData();
        },
      ),
    );
  }
  void change(String id,Records data)
  {
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        transitionAnimationController: controller,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                     await Navigator.pushNamed(context, RoutesName.quickCalcEdit,arguments: data);
                    qc.calcListData();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.edit,color: FlutterFlowTheme.of(context).success,),
                      const SizedBox(width: 10,),
                      Text("Edit",style: FlutterFlowTheme.of(context).labelMedium,)
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: VerticalDivider(
                    color: FlutterFlowTheme.of(context).iconColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    qc.deleteCalcData(id);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.delete,color: FlutterFlowTheme.of(context).error,),
                      const SizedBox(width: 10,),
                      Text("Delete",style: FlutterFlowTheme.of(context).labelMedium)
                    ],
                  ),
                )
              ],
            ),
          );
        });

  }


}
