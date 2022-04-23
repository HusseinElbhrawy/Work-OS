import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController errorSnackBar(String errorMessage) {
  return Get.snackbar(
    'something_error'.tr,
    errorMessage,
    colorText: Colors.black,
    backgroundColor: Colors.red.shade200,
  );
}

SnackbarController successsSnackBar(String message) {
  return Get.snackbar(
    'success'.tr,
    message,
    colorText: Colors.black,
    backgroundColor: Colors.green.shade200,
  );
}
