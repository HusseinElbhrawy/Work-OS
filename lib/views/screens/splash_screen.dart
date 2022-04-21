import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/utils/const/const.dart';
import 'package:work_os/utils/services/user_status.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double height = 100, width = 100;

  @override
  void initState() {
    setState(() {
      height = 150;
    });
    Timer(const Duration(seconds: 5), () async {
      Get.off(
        UserStatus().page,
        transition: Transition.fade,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Test Splash Screen',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(
              size: height,
              duration: const Duration(seconds: 1),
            ),
            Text(
              'Work OS',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: kDarkBlue,
                    fontWeight: FontWeight.bold,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
