import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:partners_leads/res/color.dart';
import 'package:partners_leads/view_model/auth_view_model.dart';
import 'package:partners_leads/view_model/services/static_value.dart';

class AddRefralView extends StatelessWidget {
  AddRefralView({super.key});

  AuthViewModel authViewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subscribe Now"),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/logo/logo.png"),
          opacity: 0.10,
        )),
        child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                  child: Text(
                "Welcome to ",
                style: TextStyle(fontSize: 25),
              )),
              SizedBox(
                height: height * 0.02,
              ),
              const Center(
                  child: Text(
                "UK Concept Designer",
                style: TextStyle(
                    fontFamily: "Georgia",
                    fontSize: 30,
                    color: Color.fromARGB(255, 212, 175, 55),
                    fontStyle: FontStyle.normal,
                    shadows: [
                      // Shadow(
                      //   offset: Offset(5.0, 5.0),
                      //   blurRadius: 3.0,
                      //   color: Color.fromARGB(134, 212, 175, 55),
                      // ),
                    ]),
              )),
              SizedBox(
                height: height * 0.08,
              ),
              const Center(
                  child: Text(
                "Please Enter Referral Code",
                style: TextStyle(fontSize: 20),
              )),
              SizedBox(
                height: height * 0.02,
              ),
              OtpTextField(
                numberOfFields: 6,
                enabledBorderColor: const Color.fromARGB(172, 109, 107, 107),
                borderColor: Theme.of(context).primaryColor,
                focusedBorderColor: Theme.of(context).primaryColor,
                cursorColor: Theme.of(context).primaryColor,
                showFieldAsBox: false,
                showCursor: false,
                textStyle: const TextStyle(fontSize: 20),
                onCodeChanged: (String code) {},
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  Map<String, String> data = {
                    'req_type': 'purchase_plan',
                    'transid': verificationCode,
                    'user_id': MyStaticValue.id
                  };
                  authViewModel.refarralApi(data, context);

                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return AlertDialog(
                  //         title: const Text("Verification Code"),
                  //         content: Text('Code entered is $verificationCode'),
                  //       );
                  //     });
                }, // end onSubmit
              ),
              SizedBox(
                height: height * 0.06,
              ),
              const Center(
                child: Text(
                  "OR",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Center(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.40,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: "\u{20B9} Pay ",
                                style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 25,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w700)),
                            WidgetSpan(
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 25,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              const Center(
                child: Text("if you Don't have referral Code"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
