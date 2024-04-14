import 'dart:convert';
import 'dart:io';

import 'package:authentication_app/global/functions.dart';
import 'package:authentication_app/global/variables.dart';
import 'package:authentication_app/pages/home.dart';
import 'package:authentication_app/widget/flush_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _loading = false;
  bool _invalidateField = false;
  bool _obscureText = true;
  String validationMessage = '';

  final _email = TextEditingController();
  final _password = TextEditingController();

  Future<void> loginPost() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      try {
        var response = await doLogin(_email.text, _password.text);
        if (response!.statusCode == 200) {
          setState(
            () {
              _loading = false;
              clearToken();
              saveToken(response.data['access_token']);
              userData = response.data['data'];
              Get.to(() => const Home());
            },
          );
        }
      } on DioException catch (e) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.connectionError) {
          setState(() {
            _loading = false;
            flushAlert(context, 'Lost Connection');
          });
        } else {
          setState(() {
            _invalidateField = true;
            validationMessage = 'Invalid Credentials';
            _loading = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    heightWidget = MediaQuery.of(context).size.height;
    widthWidget = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(
              children: [
                Text(
                  'Login Form',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: widthWidget / 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: widthWidget / 20,
                ),
                SizedBox(
                  width: widthWidget / 1.3,
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(widthWidget / 50),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 0.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 0.0),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Email / Username',
                      errorText: _invalidateField ? validationMessage : null,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: widthWidget / 1.3,
                  child: TextField(
                    controller: _password,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(widthWidget / 50),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 0.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 0.0),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Password',
                      errorText: _invalidateField ? validationMessage : null,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: widthWidget / 15,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (_email.text.isEmpty || _password.text.isEmpty) {
                      setState(() {
                        _invalidateField =
                            _email.text.isEmpty || _password.text.isEmpty;
                        validationMessage = "Field Can't Be Empty";
                      });
                    } else {
                      setState(() {
                        FocusManager.instance.primaryFocus?.unfocus();
                        _invalidateField =
                            _email.text.isEmpty || _password.text.isEmpty;
                        _loading = true;
                        loginPost();
                      });
                    }
                  },
                  child: Container(
                    width: widthWidget / 1.3,
                    height: widthWidget / 10,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueAccent,
                    ),
                    child: _loading
                        ? LoadingAnimationWidget.hexagonDots(
                            size: widthWidget / 18,
                            color: Colors.white,
                          )
                        : Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: widthWidget / 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
