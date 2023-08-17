
import 'package:partners_leads/data/response/status.dart';
import 'package:partners_leads/res/components/common.dart';
import 'package:partners_leads/res/components/drawer.dart';
import 'package:partners_leads/utils/routes/routes_name.dart';
import 'package:partners_leads/view_model/dashboard_view_model.dart';
import 'package:partners_leads/view_model/services/static_value.dart';
import 'package:provider/provider.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  DashboardViewModel dashboardViewModel = DashboardViewModel();

  @override
  void initState() {
    dashboardViewModel.fetchLeadsApi(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      child: Scaffold(
        drawer: const MyDrawer(),
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(5, 30, 10, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){
                      scaffoldKey.currentState!.openDrawer();
                    }, icon: const Icon(Icons.menu)),

                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(MyStaticValue.login_name,
                                style: FlutterFlowTheme.of(context).labelSmall,
                              ),
                              Text(
                                MyStaticValue.email,
                                style: FlutterFlowTheme.of(context).labelSmall,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/images/profile.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-1, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 30, 0, 0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${getGreeting()} ",
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                        TextSpan(
                          text: MyStaticValue.login_name,
                          style: FlutterFlowTheme.of(context).displayLarge,
                        )
                      ],
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-1, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  child: Text(
                    'My Dashboard',
                    style: FlutterFlowTheme.of(context).titleMedium,
                  ),
                ),
              ),
              Divider(
                thickness: 1,
                indent: 20,
                endIndent: 225,
                color: FlutterFlowTheme.of(context).dividercolor,
              ),

              ChangeNotifierProvider<DashboardViewModel>.value(
                  value: dashboardViewModel,
                  child: Consumer<DashboardViewModel>(builder: (context, value, _) {
                    // log(value.dashboard.toString());
                    switch (value.dashboard.status) {
                      case Status.LOADING:
                        return const Center(
                            child: CircularProgressIndicator());
                      case Status.ERROR:
                        return Center(
                            child: Text(value.dashboard.message.toString()));
                      case Status.COMPLETED:
                        // log(value.dashboard.message.toString());
                        return Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                          child: Row(
                            // mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.3,
                                height: MediaQuery.sizeOf(context).height * 0.07,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      value.dashboard.data!.result!.total ?? "",
                                      style: FlutterFlowTheme.of(context).displayMedium,
                                    ),
                                    Text(
                                      'Total Lead',
                                      style: FlutterFlowTheme.of(context).displaySmall,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.3,
                                height: MediaQuery.sizeOf(context).height * 0.07,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).buttoncolor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      value.dashboard.data!.result!.totalDealDone ?? "",
                                      style: FlutterFlowTheme.of(context).displayMedium,
                                    ),
                                    Text(
                                      'Total Deal Done',
                                      style: FlutterFlowTheme.of(context).displaySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      default:
                        break;
                    }
                    return Container();
                  })),
              Divider(
                thickness: 1,
                indent: 25,
                endIndent: 25,
                color: FlutterFlowTheme.of(context).dividercolor,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.createLeads);
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.85,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).bordercolor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.person_add,
                            color:
                            FlutterFlowTheme.of(context).secondaryiconcolor,
                            size: 15,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              'Add Client',
                              style: FlutterFlowTheme.of(context).labelMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.leadsList);
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.85,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).bordercolor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.list,
                            color:
                            FlutterFlowTheme.of(context).secondaryiconcolor,
                            size: 15,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              'Client List',
                              style: FlutterFlowTheme.of(context).labelMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.quickCalculationListView);
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.85,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).bordercolor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.list,
                            color:
                            FlutterFlowTheme.of(context).secondaryiconcolor,
                            size: 15,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              'Estimate Cost',
                              style: FlutterFlowTheme.of(context).labelMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
