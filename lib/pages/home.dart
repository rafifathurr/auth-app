import 'package:authentication_app/global/functions.dart';
import 'package:authentication_app/global/variables.dart';
import 'package:authentication_app/pages/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = false;

  Future<void> logoutPost() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      try {
        var response = await doLogout();
        if (response!.statusCode == 200) {
          clearToken();
          Get.to(() => const Login());
        }
      } on DioException catch (e) {
        logger.e(e);
        // clearToken();
        // Get.to(() => const Login());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    heightWidget = MediaQuery.of(context).size.height;
    widthWidget = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              Text(
                'Selamat Datang \n${userData['name']}',
                style: TextStyle(
                  fontSize: widthWidget / 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _loading = true;
                    logoutPost();
                  });
                },
                child: Container(
                  width: widthWidget / 1.3,
                  height: widthWidget / 10,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                  child: _loading
                      ? LoadingAnimationWidget.hexagonDots(
                          size: widthWidget / 18,
                          color: Colors.white,
                        )
                      : Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: widthWidget / 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
