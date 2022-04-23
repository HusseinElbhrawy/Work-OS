import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:work_os/utils/const/const.dart';
import 'package:work_os/views/widgets/snack_bar.dart';

class AddTaskController extends GetxController {
  final TextEditingController taskCategoryController =
          TextEditingController(text: 'task_category'.tr),
      taskTitleController = TextEditingController(),
      taskDescriptionController = TextEditingController(),
      deadlineDateController = TextEditingController(text: 'pick_up_date'.tr);

  final formKey = GlobalKey<FormState>();
  Timestamp? _deadlineDateTimeStamp;

  void updateDate(DateTime? value) {
    deadlineDateController.text = '${value!.year}/${value.month}/${value.day}';
    _deadlineDateTimeStamp =
        Timestamp.fromMicrosecondsSinceEpoch(value.microsecondsSinceEpoch);
    update();
  }

  void customDatePicker(context) async {
    showDatePicker(
      context: context,
      cancelText: 'cancel'.tr,
      confirmText: 'confirm'.tr,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((DateTime? value) => updateDate(value)).catchError(
      (error) {
        Get.snackbar(
          'warning'.tr,
          'please_select_date'.tr,
          colorText: Colors.black,
          backgroundColor: Colors.red.shade300,
        );
      },
    );
  }

  void _clearControllers() {
    taskCategoryController.clear();
    taskTitleController.clear();
    taskDescriptionController.clear();
    deadlineDateController.clear();
  }

  RxBool isTaskUploading = false.obs;
  void uploadTask() async {
    isTaskUploading.value = true;
    final taskId = const Uuid().v4();
    try {
      await FirebaseFirestore.instance.collection('tasks').doc(taskId).set(
        {
          'TaskID': taskId,
          'UploadedBy': kCurrentUserUid,
          'TaskTitle': taskTitleController.text.toString(),
          'TaskDescription': taskDescriptionController.text.toString(),
          'DeadlineDate': deadlineDateController.text.toString(),
          'DeadlineDateTimeStamp': _deadlineDateTimeStamp,
          'TaskCategory': taskCategoryController.text.toString(),
          'TaskComments': [],
          'IsDone': false,
          'CreatedAt': Timestamp.now(),
        },
      );
      log('Done');

      successsSnackBar('uploaed_task_suceesfully'.tr);
    } catch (e) {
      errorSnackBar('something_error'.tr);
      log(e.toString());
    } finally {
      _clearControllers();
      isTaskUploading.value = false;
    }
  }

  @override
  void onClose() {
    log('On Closed Start');
    taskCategoryController.dispose();
    taskTitleController.dispose();
    taskDescriptionController.dispose();
    deadlineDateController.dispose();

    super.onClose();
    log('On Closed Start');
  }
}
