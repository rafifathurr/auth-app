import 'dart:io';

import 'package:authentication_app/global/functions.dart';
import 'package:authentication_app/global/variables.dart';
import 'package:authentication_app/pages/home.dart';
import 'package:authentication_app/pages/login.dart';
import 'package:authentication_app/widget/flush_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Validation {
  authenticationCheck() async {
    try {
      var response = await sessionCheck();
      if (response!.statusCode == 200) {
        userData = response.data['data'];
        return true;
      }
    } on DioException {
      return false;
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool validationStat = await Validation().authenticationCheck();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: validationStat ? const Home() : const Login(),
    ),
  );
}
