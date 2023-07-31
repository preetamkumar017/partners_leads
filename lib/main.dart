import 'package:flutter/material.dart';
import 'package:partners_leads/utils/routes/routes.dart';
import 'package:partners_leads/utils/routes/routes_name.dart';
import 'package:partners_leads/view_model/add_followup_view_model.dart';
import 'package:partners_leads/view_model/auth_view_model.dart';
import 'package:partners_leads/view_model/create_leads_view_model.dart';
import 'package:partners_leads/view_model/leads_view_model.dart';
import 'package:partners_leads/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => CreateLeadsViewModel()),
        ChangeNotifierProvider(create: (_) => LeadsViewModel()),
        ChangeNotifierProvider(create: (_) => AddFollowupViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Partners Leads',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color(0xFF00BCD4),
          primaryColorDark: const Color(0xff0097A7),
          primaryColorLight: const Color(0xFFB2EBF2),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF00BCD4),
            centerTitle: true,
          ),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: const Color(0xFFFF4081)),
          iconTheme: const IconThemeData(color: Color.fromARGB(255, 111, 115, 116)),
          primaryIconTheme:
              const IconThemeData(color: Color.fromARGB(255, 111, 115, 116)),
          androidOverscrollIndicator: AndroidOverscrollIndicator.glow,
          fontFamily: 'Georgia',
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 26.0, fontStyle: FontStyle.normal),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        //   colorScheme: ColorScheme.fromSwatch()
        //       .copyWith(secondary: const Color(0xFFFF4081)),
        ),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
