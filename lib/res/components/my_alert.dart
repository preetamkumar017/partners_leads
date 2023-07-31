import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:partners_leads/res/color.dart';
import 'package:partners_leads/res/components/round_button.dart';
import 'package:partners_leads/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class MyAlert {
  static myCallAlert(BuildContext context, data) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Please confirm '),
        content: const Text('Make sure you want to make this call!!'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await FlutterPhoneDirectCaller.callNumber(data);
              Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

//'Your Device not register With us!! send request to register'
  static deviceRequest(BuildContext context, data) async {
    AuthViewModel authViewMode = AuthViewModel();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Alert!',
            style: TextStyle(color: Color.fromARGB(255, 240, 0, 0))),
        content: const Text(
            "Your Device has not been registered...\nSend registration request to admin...",
            style: TextStyle(color: Colors.black, fontSize: 16)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          RoundButton(
              loading: authViewMode.signUpLoading,
              title: 'Send Request',
              onPress: () {
                data['req_type'] = "device_register";
                print(data);
                authViewMode.addDeviceApi(data, context);
              })
        ],
      ),
    );
  }
}
