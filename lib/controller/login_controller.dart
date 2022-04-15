import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/views/widgets/error_snack_bar.dart';

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

  bool isLoading = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> loginAccount({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      log(credential.user!.uid);
      isLoading = false;
      clearControllers();
      // Get.off(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorSnackBar('No user found for that email.');
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        errorSnackBar('Wrong password provided for that user.');
        log('Wrong password provided for that user.');
      }
      isLoading = false;
    } catch (e) {
      isLoading = false;
      errorSnackBar(e.toString());
      log(e.toString());
    }
    update();
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
