import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:partners_leads/res/components/round_button.dart';
import 'package:partners_leads/utils/utils.dart';
import 'package:partners_leads/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';
import 'package:unique_identifier/unique_identifier.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _groupController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode mobileFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode groupFocusNode = FocusNode();

  String? _identifier = 'Unknown';
  String? _brand = 'Unknown';
  String? _model = 'Unknown';
  String? _manufacturer = 'Unknown';

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    _groupController.dispose();

    nameFocusNode.dispose();
    emailFocusNode.dispose();
    mobileFocusNode.dispose();
    addressFocusNode.dispose();
    groupFocusNode.dispose();

    _obsecurePassword.dispose();
  }

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

    _deviceData = deviceData;
  }

  void _readAndroidBuildData(AndroidDeviceInfo build) {
    _brand = build.board;
    _model = build.model;
    _manufacturer = build.manufacturer;
  }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
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
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        focusNode: nameFocusNode,
                        decoration: const InputDecoration(
                            hintText: 'Full Name',
                            labelText: 'Full Name',
                            prefixIcon: Icon(Icons.person)),
                        onFieldSubmitted: (value) {
                          Utils.fieldFocusChange(
                              context, nameFocusNode, emailFocusNode);
                        },
                      ),
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
                              context, emailFocusNode, mobileFocusNode);
                        },
                      ),
                      TextFormField(
                        controller: _mobileController,
                        keyboardType: TextInputType.number,
                        focusNode: mobileFocusNode,
                        maxLength: 10,
                        decoration: const InputDecoration(
                            hintText: 'Mobile Number',
                            labelText: 'Mobile Number',
                            counterText: "",
                            prefixIcon: Icon(Icons.phone)),
                        onFieldSubmitted: (valu) {
                          Utils.fieldFocusChange(
                              context, mobileFocusNode, addressFocusNode);
                        },
                      ),
                      TextFormField(
                        controller: _addressController,
                        keyboardType: TextInputType.multiline,
                        focusNode: addressFocusNode,
                        maxLines: 2,
                        decoration: const InputDecoration(
                            hintText: 'Address',
                            labelText: 'Address',
                            prefixIcon: Icon(Icons.location_city)),
                        onFieldSubmitted: (valu) {
                          Utils.fieldFocusChange(
                              context, addressFocusNode, groupFocusNode);
                        },
                      ),
                      TextFormField(
                        controller: _groupController,
                        keyboardType: TextInputType.number,
                        focusNode: groupFocusNode,
                        maxLength: 4,
                        decoration: const InputDecoration(
                            hintText: 'Group Code',
                            labelText: 'Group Code',
                            counterText: "",
                            prefixIcon: Icon(Icons.group)),
                        onFieldSubmitted: (valu) {
                          Utils.fieldFocusChange(
                              context, groupFocusNode, groupFocusNode);
                        },
                      ),
                      SizedBox(
                        height: height * .085,
                      ),
                      RoundButton(
                        title: 'Sign up',
                        loading: authViewMode.signUpLoading,
                        onPress: () async {
                         await initPlatformState();
                         await initUniqueIdentifierState();
                          if (_nameController.text.isEmpty) {
                            Utils.flushBarErrorMessage( 'Please enter name', context);
                          } else if (_emailController.text.isEmpty) {
                            Utils.flushBarErrorMessage( 'Please enter Email', context);
                          } else if (_mobileController.text.isEmpty) {
                            Utils.flushBarErrorMessage(
                                'Please enter Mobile number', context);
                          } else if (_mobileController.text.length < 10) {
                            Utils.flushBarErrorMessage(
                                'Please enter valid Mobile number', context);
                          } else if (_addressController.text.isEmpty) {
                            Utils.flushBarErrorMessage(
                                'Please enter Address', context);
                          }
                          // else if (_groupController.text.isEmpty) {
                          //   Utils.flushBarErrorMessage(
                          //       'Please enter Group code', context);
                          // } else if (_groupController.text.length < 4) {
                          //   Utils.flushBarErrorMessage(
                          //       'Please enter 4 digit group code', context);
                          // }
                          else {
                            Map<String, String> data = {
                              'req_type': 'signup',
                              'name': _nameController.text.toString(),
                              'email': _emailController.text
                                  .toString()
                                  .toLowerCase(),
                              'mobile': _mobileController.text.toString(),
                              'address': _addressController.text.toString(),
                              'group_code': _groupController.text.toString(),
                              'device_type': "app",
                              'mobile_brand': _brand!,
                              'model': _model!,
                              'mobile_uid': _identifier!,
                              'manufacturer': _manufacturer!
                            };

                            log(data.toString());

                            authViewMode.signUpApi(data, context);
                          }
                        },
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      InkWell(
                          onTap: () {
                            // Navigator.pop(context);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Alrady have an account?"),
                              Text(
                                "\t\tLogin",
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
