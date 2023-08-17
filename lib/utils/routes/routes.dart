import 'package:flutter/material.dart';
import 'package:partners_leads/model/QuickCalcListModel.dart';
import 'package:partners_leads/model/arguments.dart';
import 'package:partners_leads/res/components/audio_player.dart';
import 'package:partners_leads/res/components/image_viewer.dart';
import 'package:partners_leads/view/dashboard.dart';
import 'package:partners_leads/view/group_view.dart';
import 'package:partners_leads/utils/routes/routes_name.dart';
import 'package:partners_leads/view/add_followup_view.dart';
import 'package:partners_leads/view/add_followup_view_new.dart';
import 'package:partners_leads/view/add_refral_view.dart';
import 'package:partners_leads/view/change_password.dart';
import 'package:partners_leads/view/create_leads.dart';
import 'package:partners_leads/view/deal_done_view.dart';
import 'package:partners_leads/view/edit_leads_view.dart';
import 'package:partners_leads/view/followup_details_view.dart';
import 'package:partners_leads/view/leads_list.dart';
import 'package:partners_leads/view/login_view.dart';
import 'package:partners_leads/view/profile_view.dart';
import 'package:partners_leads/view/quck_calc_view.dart';
import 'package:partners_leads/view/quck_calc_view_edit.dart';
import 'package:partners_leads/view/quick_calc_details.dart';
import 'package:partners_leads/view/quick_calc_list_view.dart';
import 'package:partners_leads/view/signp_view.dart';
import 'package:partners_leads/view/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashView());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());

      case RoutesName.profile:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ProfileView());

      case RoutesName.createLeads:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CreateLeads());

      case RoutesName.leadsList:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LeadsList());

      case RoutesName.groupList:
        final args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
            builder: (BuildContext context) =>  GroupList(arg_data: args.data,));

      case RoutesName.editLeads:
        final args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
            builder: (BuildContext context) => EditeLeadsView(
                  arg_data: args.data,
                ));
      case RoutesName.dealDoneView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DealDoneView());
      case RoutesName.addFollowupnew:
        final args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                AddFollowViewNew(pdata: args.data));
      case RoutesName.addFollowup:
        final args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
            builder: (BuildContext context) => AddFollowup(data: args.data));
      case RoutesName.followupDetails:
        final args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                FollowupDetails(data: args.data));
      case RoutesName.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpView());
      case RoutesName.audio_player:
        final args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
            builder: (BuildContext context) => MyAudioPlayer(data: args.data));
      case RoutesName.image_viewer:
        final args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(builder: (BuildContext context) => MyImageView(data: args.data));
      case RoutesName.refral:
        return MaterialPageRoute(
            builder: (BuildContext context) => AddRefralView());
      case RoutesName.changePassword:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Changepassword());
      case RoutesName.dashboard:
              return MaterialPageRoute(
                  builder: (BuildContext context) => const DashboardView());
      case RoutesName.quickCalc:
              return MaterialPageRoute(
                  builder: (BuildContext context) => const QuickCalculationView());
      case RoutesName.quickCalcEdit:

        Records args = settings.arguments as Records;
              return MaterialPageRoute(
                  builder: (BuildContext context) =>  QuickCalculationEditView(args));
      case RoutesName.quickCalculationListView:
              return MaterialPageRoute(
                  builder: (BuildContext context) => const QuickCalculationListView());
      case RoutesName.quickCalcDetails:
        Records args = settings.arguments as Records;
              return MaterialPageRoute(
                  builder: (BuildContext context) =>  QuickCalcDetailsView(args));

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
