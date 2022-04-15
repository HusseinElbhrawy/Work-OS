import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work_os/utils/const/const.dart';
import 'package:work_os/views/screens/home.dart';
import 'package:work_os/views/widgets/error_snackbar.dart';

class SignUpController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  late AnimationController controller;
  late Animation<double> animation;
  final fullNameFocusNode = FocusNode(),
      emailFocusNode = FocusNode(),
      companyPosition = FocusNode(),
      phoneNumber = FocusNode();

  final passwordFocusNode = FocusNode();

  final emailController = TextEditingController(),
      passwordController = TextEditingController(),
      fullNameController = TextEditingController(),
      companyPositionController = TextEditingController(),
      phoneController = TextEditingController();

  File? pickedImage;
  final ImagePicker picker = ImagePicker();

  void pickedImageMethod({required ImageSource src}) async {
    picker
        .pickImage(
      source: src,
      maxWidth: 1080,
      maxHeight: 1080,
    )
        .then((value) async {
      if (value != null) {
        cropImage(value.path);
        Get.back();
      } else {
        Get.back();
        throw 'Please Select an Image';
      }
    }).catchError(
      (error) {
        log("User didn't picked image yet");
        Get.snackbar(
          'Warning',
          error,
          colorText: kDarkBlue,
          backgroundColor: Colors.white,
        );
      },
    );
  }

  void cropImage(path) async {
    ImageCropper()
        .cropImage(
      sourcePath: path,
    )
        .then((value) {
      if (value != null) {
        pickedImage = value;
        update();
      } else {
        Get.back();
        throw 'Please Select an Image';
      }
    }).catchError((error) {
      Get.snackbar(
        'Warning',
        error,
        colorText: kDarkBlue,
        backgroundColor: Colors.white,
      );
    });
  }

  final List<String> jobList = [
    'Manager',
    'Team Leader',
    'Designer',
    'Web Designer',
    'Full Stack Developer',
    'Mobile Developer',
    'Marketing',
    'Digital Marketing',
  ];

  bool isObscureText = true;
  IconData iconData = Icons.visibility;
  void changePasswordSuffixIcon() {
    isObscureText = !isObscureText;
    update();
  }

  void clearControllers() {
    passwordController.clear();
    emailController.clear();
    fullNameController.clear();
    phoneController.clear();
    companyPositionController.clear();
  }

  bool isLoading = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> createAccount({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      isLoading = false;
      clearControllers();
      Get.off(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorSnackBar('The password provided is too weak.');
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        errorSnackBar('The account already exists for that email.');
        log('The account already exists for that email.');
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
  void onInit() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 20))
          ..repeat();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    super.onInit();
  }

  @override
  void onClose() {
    log('On Closed Start');
    controller.dispose();
    companyPositionController.dispose();
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    fullNameFocusNode.dispose();
    emailFocusNode.dispose();
    companyPosition.dispose();
    phoneNumber.dispose();
    passwordFocusNode.dispose();
    super.onClose();
    log('On Closed End');
  }

  @override
  void dispose() {
    log('Disposed Start');
    controller.dispose();
    companyPositionController.dispose();
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    fullNameFocusNode.dispose();
    emailFocusNode.dispose();
    companyPosition.dispose();
    phoneNumber.dispose();
    passwordFocusNode.dispose();
    super.dispose();
    log('Disposed End');
  }
}
