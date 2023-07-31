import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:partners_leads/model/followup_details_model.dart';
import 'package:partners_leads/res/components/my_alert.dart';
import 'package:partners_leads/res/components/round_button.dart';
import 'package:partners_leads/utils/routes/routes_name.dart';
import 'package:partners_leads/utils/utils.dart';
import 'package:partners_leads/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'package:unique_identifier/unique_identifier.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  @override
  void initState() {
    super.initState();

    initUniqueIdentifierState();
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obsecurePassword.dispose();
  }

  String? _identifier = 'Unknown';
  String? _brand = 'Unknown';
  String? _model = 'Unknown';
  String? _manufacturer = 'Unknown';

  Future<void> initUniqueIdentifierState() async {
    String? identifier;
    try {
      identifier = await UniqueIdentifier.serial;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }

    if (!mounted) return;

    _identifier = identifier;
  }

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {});
  }

  void _readAndroidBuildData(AndroidDeviceInfo build) {
    _brand = build.board;
    _model = build.model;
    _manufacturer = build.manufacturer;
  }

  @override
  Widget build(BuildContext context) {
    initPlatformState();
    final authViewMode = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Image(
                  image: const AssetImage("assets/logo/logo.png"),
                  height: height * 0.15),
              Card(
                margin: const EdgeInsets.all(18.0),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        focusNode: emailFocusNode,
                        decoration: const InputDecoration(
                            hintText: 'Email',
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.alternate_email)),
                        onFieldSubmitted: (valu) {
                          Utils.fieldFocusChange(
                              context, emailFocusNode, passwordFocusNode);
                        },
                      ),
                      ValueListenableBuilder(
                          valueListenable: _obsecurePassword,
                          builder: (context, value, child) {
                            return TextFormField(
                              controller: _passwordController,
                              obscureText: _obsecurePassword.value,
                              focusNode: passwordFocusNode,
                              obscuringCharacter: "*",
                              decoration: InputDecoration(
                                hintText: 'Password',
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock_open_rounded),
                                suffixIcon: InkWell(
                                    onTap: () {
                                      _obsecurePassword.value =
                                          !_obsecurePassword.value;
                                    },
                                    child: Icon(_obsecurePassword.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility)),
                              ),
                            );
                          }),
                      SizedBox(
                        height: height * .085,
                      ),
                      RoundButton(
                        title: 'Login',
                        loading: authViewMode.loading,
                        onPress: () {
                          if (_emailController.text.isEmpty) {
                            Utils.flushBarErrorMessage(
                                'Please enter email', context);
                          } else if (_passwordController.text.isEmpty) {
                            Utils.flushBarErrorMessage(
                                'Please enter password', context);
                          } else if (_passwordController.text.length < 6) {
                            Utils.flushBarErrorMessage(
                                'Please enter 6 digit password', context);
                          } else {
                            Map data = {
                              'req_type': 'login',
                              'email': _emailController.text.toString(),
                              'password': _passwordController.text.toString(),
                              'device_type': "app",
                              'mobile_brand': _brand,
                              'model': _model,
                              'mobile_uid': _identifier,
                              'manufacturer': _manufacturer
                            };

                            authViewMode.loginApi(data, context);
                          }
                        },
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RoutesName.signUp);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              Text(
                                "\t\tSign Up Now",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ))
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
}
