import 'dart:developer';

import 'package:get/get.dart';
import 'package:partners_leads/data/response/status.dart';
import 'package:partners_leads/view_model/price_list_view_controller.dart';
import 'package:partners_leads/view_model/quick_calc_view_model.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:partners_leads/model/price_rate_model.dart';

class QuickCalculationEditView extends StatefulWidget {
  const QuickCalculationEditView({Key? key}) : super(key: key);

  @override
  _QuickCalculationEditViewState createState() => _QuickCalculationEditViewState();
}

class _QuickCalculationEditViewState extends State<QuickCalculationEditView>  with TickerProviderStateMixin {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final qcController  = Get.put(QuickCalcController());
  final plController  = Get.put(PriceListController());

  late AnimationController controller;

  @override
  void initState() {
    plController.getData();

    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 1000);
    controller.reverseDuration =  const Duration(milliseconds: 750);
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
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
                        'Quick Calculation',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).headlineSmall,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Text(
                    'Here you can calculate\n estimate cost of project',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).labelMedium,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/quick_cal_image.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Text(
                    'Fill the Form for estimate calculation',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).labelMedium,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: MediaQuery.sizeOf(context).height * 0.08,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).bordercolor,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.2,
                        height: 100,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(0),
                          ),
                        ),
                        child: Padding(
                          padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/call.png',
                              width: 300,
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: VerticalDivider(
                          thickness: 1,
                          color: FlutterFlowTheme.of(context).bordercolor,
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.628,
                        height: MediaQuery.sizeOf(context).height * 1,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child:  Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: TextFormField(
                            // controller: qcController.textController1,
                            obscureText: false,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelStyle: FlutterFlowTheme.of(context).labelLarge,
                              hintText: 'Enter Mobile Number',
                              hintStyle: FlutterFlowTheme.of(context).labelLarge,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                            style: FlutterFlowTheme.of(context).labelLarge,
                            maxLines: null,
                            // validator: qcController.textController1Validator
                            //     .asValidator(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: MediaQuery.sizeOf(context).height * 0.08,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).bordercolor,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.2,
                        height: 100,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(0),
                          ),
                        ),
                        child: Padding(
                          padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/plot_size.png',
                              width: 300,
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: VerticalDivider(
                          thickness: 1,
                          color: FlutterFlowTheme.of(context).bordercolor,
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.628,
                        height: MediaQuery.sizeOf(context).height * 1,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child:  Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: TextFormField(
                            // controller: qcController.textController2,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelStyle:
                              FlutterFlowTheme.of(context).labelLarge,
                              hintText: 'Enter Plot Length',
                              hintStyle:
                              FlutterFlowTheme.of(context).labelLarge,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                            style: FlutterFlowTheme.of(context).labelLarge,
                            maxLines: null,
                            // validator: qcController.textController2Validator
                            //     .asValidator(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: MediaQuery.sizeOf(context).height * 0.08,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).bordercolor,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.2,
                        height: 100,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(0),
                          ),
                        ),
                        child: Padding(
                          padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/plot_size.png',
                              width: 300,
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: VerticalDivider(
                          thickness: 1,
                          color: FlutterFlowTheme.of(context).bordercolor,
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.628,
                        height: MediaQuery.sizeOf(context).height * 1,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child:  Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: TextFormField(
                            // controller: qcController.textController2,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelStyle:
                              FlutterFlowTheme.of(context).labelLarge,
                              hintText: 'Enter Plot Width',
                              hintStyle:
                              FlutterFlowTheme.of(context).labelLarge,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                            style: FlutterFlowTheme.of(context).labelLarge,
                            maxLines: null,
                            // validator: qcController.textController2Validator
                            //     .asValidator(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: MediaQuery.sizeOf(context).height * 0.08,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).bordercolor,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.2,
                        height: 100,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(0),
                          ),
                        ),
                        child: Padding(
                          padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/floor.png',
                              width: 300,
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: VerticalDivider(
                          thickness: 1,
                          color: FlutterFlowTheme.of(context).bordercolor,
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.628,
                        height: MediaQuery.sizeOf(context).height * 1,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child:  Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: TextFormField(
                            controller: qcController.floorNumber.value,
                            obscureText: false,
                            readOnly: true,
                            keyboardType: TextInputType.none,
                            onTap: () => selectFloor(),
                            decoration: InputDecoration(
                              labelStyle:
                              FlutterFlowTheme.of(context).labelLarge,
                              hintText: 'Enter Number of floor',
                              hintStyle: FlutterFlowTheme.of(context).labelLarge,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                            style: FlutterFlowTheme.of(context).labelLarge,
                            maxLines: null,
                            // validator: qcController.textController3Validator
                            //     .asValidator(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: MediaQuery.sizeOf(context).height * 0.08,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).bordercolor,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.2,
                        height: 100,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(0),
                          ),
                        ),
                        child: Padding(
                          padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/price.png',
                              width: 300,
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: VerticalDivider(
                          thickness: 1,
                          color: FlutterFlowTheme.of(context).bordercolor,
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.628,
                        height: MediaQuery.sizeOf(context).height * 1,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child:  Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: TextFormField(
                            controller: qcController.rate.value,
                            readOnly: true,
                            obscureText: false,
                            keyboardType: TextInputType.none,
                            onTap: () {
                              selectRate();
                            },
                            decoration: InputDecoration(
                              labelStyle: FlutterFlowTheme.of(context).labelLarge,
                              hintText: 'Enter Rate of the Selection',
                              hintStyle: FlutterFlowTheme.of(context).labelLarge,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                            style: FlutterFlowTheme.of(context).labelLarge,
                            maxLines: null,
                            // validator: qcController.textController4Validator
                            //     .asValidator(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                child: FFButtonWidget(
                  onPressed: () {
                  },
                  text: 'Calculate Now',
                  options: FFButtonOptions(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 5, 20, 5),
                    iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: FlutterFlowTheme.of(context).buttoncolor,
                    textStyle: FlutterFlowTheme.of(context).displaySmall,
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  void selectFloor()
  {
    log(qcController.floor.length.toString());
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
      transitionAnimationController: controller,
          context: context,
          builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            color: Colors.white,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 18, 0, 0),
                  child: Text(
                    'Select Floor',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Wrap(
                  spacing: 20.0,
                  alignment: WrapAlignment.center,
                  children: [
                    for (int floor = 0; floor < qcController.floor.length; floor++)
                      Obx(() {
                        return ChoiceChip(label:  Text("$floor${floor == 1 ? 'st' : floor == 2 ? 'nd' : floor == 3 ? 'rd' : 'th'} floor",),
                          selected: qcController.floor[floor],
                          selectedColor: FlutterFlowTheme.of(context).bordercolor,
                          onSelected: (value) {
                            for (int i = 0; i < qcController.floor.length; i++) {
                              qcController.floor[i] = i == floor && value;
                            }
                            qcController.floorNumber.value.text = floor.toString();
                            Navigator.pop(context);
                            // Get.back();
                          },
                          elevation: 1.0,
                          backgroundColor:Colors.white,
                          labelStyle:  FlutterFlowTheme.of(context).bodyLarge,
                          iconTheme:  IconThemeData(
                            color: qcController.floor[floor]  ? Colors.white: FlutterFlowTheme.of(context).iconColor,
                            size: 18.0,),
                        );
                      }),
                  ],
                ),
              )

            ],
          ),
        );
    });

  }

  final List<Widget> dynamicData = [];


  void selectRate()
  {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
        transitionAnimationController: controller,
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: Colors.white,
            ),
            child: ListView(
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 18, 0, 0),
                  child: Text(
                    'Select Rate',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
                ),
                Obx(() {
                  switch (plController.getStatus) {
                    case Status.LOADING:
                      return const Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return const Center(child: Text("Something Went Wrong"));
                    case Status.EMPTY:
                      return const Center(child: Text("Data not Found"));
                    case Status.COMPLETED:
                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Wrap(
                          spacing: 20,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runAlignment: WrapAlignment.spaceAround,
                          children: [
                            for(int indx = 0;indx < plController.getPriceRate.result!.length;indx++)
                              ChoiceChip(
                                label: Text(plController.getPriceRate.result![indx].floorPrice ?? ""),
                                selected: plController.rate[indx],
                                selectedColor: FlutterFlowTheme.of(context).bordercolor,
                                onSelected: (value) {
                                  for (int i = 0; i < plController.rate.length; i++) {
                                    plController.rate[i] = (i == indx) ? value : false;
                                    if(i==indx) qcController.rate.value.text = plController.getPriceRate.result![i].floorPrice.toString();
                                  }

                                  Navigator.pop(context);
                                },
                                elevation: 1.0,
                                backgroundColor: Colors.white,
                                labelStyle: FlutterFlowTheme.of(context).bodyLarge,
                                iconTheme: IconThemeData(
                                  color: plController.rate[indx]
                                      ? Colors.white
                                      : FlutterFlowTheme.of(context).iconColor,
                                  size: 18.0,
                                ),
                              )

                          ],
                        ),
                      );
                    default:
                      return Container();
                  }
                }),

              ],
            ),
          );
        });

  }
}
