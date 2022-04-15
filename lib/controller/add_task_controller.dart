import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskController extends GetxController {
  final TextEditingController taskCategoryController =
          TextEditingController(text: 'Task Category'),
      taskTitleController = TextEditingController(),
      taskDescriptionController = TextEditingController(),
      deadlineDateController = TextEditingController(text: 'Pick up a date');

  final formKey = GlobalKey<FormState>();

  void updateDate(value) {
    deadlineDateController.text = '${value!.year}/${value.month}/${value.day}';
    update();
  }

  void customDatePicker(context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((value) => updateDate(value)).catchError(
      (error) {
        Get.snackbar(
          'Warning',
          'Please Select a Date',
          colorText: Colors.black,
          backgroundColor: Colors.red.shade300,
        );
      },
    );
  }

  @override
  void onClose() {
    log('On Closed Start');
    super.onClose();
    log('On Closed Start');
  }
}
