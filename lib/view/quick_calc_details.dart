import 'dart:io';

import 'package:partners_leads/model/QuickCalcListModel.dart';
import 'package:partners_leads/res/components/common.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class QuickCalcDetailsView extends StatefulWidget {
  Records data;

  QuickCalcDetailsView(this.data, {super.key});

  @override
  _QuickCalcDetailsViewState createState() => _QuickCalcDetailsViewState();
}

class _QuickCalcDetailsViewState extends State<QuickCalcDetailsView> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late ScreenshotController screenshotController;
  late File tempFile;
  late Records data ;


  @override
  void initState() {
    super.initState();
    data = widget.data;
    screenshotController = ScreenshotController();
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
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 20,
                decoration: const BoxDecoration(),
              ),
              Align(
                alignment: const AlignmentDirectional(1, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                  child: InkWell(
                    onTap: () {
                      shareScreenshot();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).highlightcolor,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: Icon(Icons.share_sharp,color: FlutterFlowTheme.of(context).highlightcolor,)
                                // Image.asset(
                                //   'assets/images/share.png',
                                //   width: 20,
                                //   height: 20,
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                              child: Text(
                                'Share It',
                                style: FlutterFlowTheme.of(context).displayLarge,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Screenshot(
                controller: screenshotController,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/business.png',
                            width: 300,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Hey, ',
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                              TextSpan(
                                text: data.mobile ?? "",
                                style: FlutterFlowTheme.of(context).titleSmall,
                              ),
                              TextSpan(
                                text:
                                ' here is your Estimate cost calculation of your dream house',
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              )
                            ],
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 30, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color:
                                  FlutterFlowTheme.of(context).secondaryBackground,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.asset(
                                    'assets/images/plot_size.png',
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                                child: Text(
                                  'Plot Size: ${data.totalArea ?? ""} sq.ft',
                                  style: FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 30, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color:
                                  FlutterFlowTheme.of(context).secondaryBackground,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.asset(
                                    'assets/images/floor.png',
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                                child: Text(
                                  'No. of floor: ${data.floor ?? ""}th Floor',
                                  style: FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 30, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color:
                                  FlutterFlowTheme.of(context).secondaryBackground,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.asset(
                                    'assets/images/price.png',
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                                child: Text(
                                  'Rate of selection: Rs. ${data.rate ?? ""}',
                                  style: FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                      ),
                      Text(
                        'Estimate Cost Calculation',
                        style: FlutterFlowTheme.of(context).titleSmall,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Text(
                          'Rs. ${formatNumber(double.parse(data.projectCost ?? ""))}',
                          style: FlutterFlowTheme.of(context).headlineMedium.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).highlightcolor,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Powered By:  ',
                                  style: FlutterFlowTheme.of(context).labelLarge,
                                ),
                                TextSpan(
                                  text: 'UK Concept Designer',
                                  style: FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Poppins',
                                    color:
                                    FlutterFlowTheme.of(context).highlightcolor,
                                  ),
                                )
                              ],
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> shareScreenshot() async {
    final image = await screenshotController.capture();
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    tempFile = File('${appDocumentsDir.path}/screenshot.png');
    await tempFile.writeAsBytes(image!);
    print('Screenshot saved to ${tempFile.path}');
    if (tempFile != null) {
      await Share.shareFiles([tempFile.path],subject: "Screenshot Subject",text:"This is only Estimate Calculation\n For more accuracy contact us:- \n UK Concept Designer, Raipur\n Office 441 4t floor,\n Labhandi Rd, Jivan Vihar, \n Raipur, Chhattisgarh 492001\n 7880055446");
    }
  }
}
