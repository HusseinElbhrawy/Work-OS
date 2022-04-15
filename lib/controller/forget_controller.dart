import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  final emailController = TextEditingController();
  @override
  void onInit() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 20))
          ..repeat();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    emailController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    controller.dispose();
    emailController.dispose();
    super.dispose();
  }
}
