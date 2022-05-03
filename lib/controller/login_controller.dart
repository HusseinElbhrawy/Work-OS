import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/utils/services/user_status.dart';
import 'package:work_os/views/screens/home/home.dart';

import '../views/widgets/snack_bar.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  final formKey = GlobalKey<FormState>(debugLabel: 'Key1');

  bool isObscureText = true;
  IconData iconData = Icons.visibility;

  final emailController = TextEditingController(),
      passwordController = TextEditingController();

  final emailFocusNode = FocusNode(), passwordFocusNode = FocusNode();

  @override
  void onInit() {
    log('On Init Start');
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 20))
          ..repeat();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    clearControllers();
    super.onInit();
  }

  void updateIcon() {
    isObscureText = !isObscureText;
    update();
  }

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
  }

  RxBool isLoading = false.obs;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> loginAccount({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      log(credential.user!.uid);
      isLoading.value = false;
      clearControllers();
      UserStatus().saveToBox(true);
      Get.offAll(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorSnackBar('no_user_found_for_that_email'.tr);
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        errorSnackBar('wrong_password_provided_for_that_user'.tr);
        log('Wrong password provided for that user.');
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorSnackBar(e.toString());
      log(e.toString());
    }
  }

  @override
  void onClose() {
    log('On Close Start');
    controller.dispose();
    passwordController.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
    log('On Close End');
  }

  @override
  void dispose() {
    log('Dispose Start');
    controller.dispose();
    passwordController.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
    log('Dispose End');
  }
}
