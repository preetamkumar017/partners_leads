import 'package:flutter/material.dart';
import 'package:partners_leads/view_model/services/splash_services.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.checkAuthentication(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration:const BoxDecoration(
          image:  DecorationImage(
            image: AssetImage("assets/logo/logo.png"),
            fit: BoxFit.fitWidth,
          ),
        )
      ),
    );
  }
}
