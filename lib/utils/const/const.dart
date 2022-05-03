import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/controller/all_worker_controller.dart';
import 'package:work_os/controller/my_account_controller.dart';
import 'package:work_os/utils/services/user_status.dart';
import 'package:work_os/views/screens/login/login.dart';

const kDarkBlue = Color(0xff00325a);

const kScaffoldBGColor = Color(0xffede7dc);
const kDarkModeItemColor = Color.fromARGB(255, 35, 43, 65);
// const kScaffoldBGColor = Color(0xffede7dc);

void logOut() async {
  log('Log Out Start');
  Get.back();
  await FirebaseAuth.instance.signOut().then((value) {
    log('Start');
    Get.offAll(() => const LoginScreen());
    UserStatus().saveToBox(false);
    Get.delete<MyAccountController>(force: true);
    Get.delete<AllWorkersController>(force: true);

    log('End');
  });
}

String kCurrentUserUid = FirebaseAuth.instance.currentUser!.uid.toString();
