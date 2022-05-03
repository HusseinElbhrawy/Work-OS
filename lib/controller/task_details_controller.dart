import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:work_os/controller/my_account_controller.dart';
import 'package:work_os/views/widgets/snack_bar.dart';

class TaskDetailsController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final MyAccountController _accountController = Get.put(MyAccountController());
  TextEditingController commentController = TextEditingController();
  RxBool isTaskDone = false.obs;
  bool isCommenting = false;
  List<Color> profileBorderColor = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.teal,
    Colors.amber,
  ];

  void toggleBetweenIsComment() {
    isCommenting = !isCommenting;
    update();
  }

  static String? taskId, _uploadBy;
  static RxBool loadingData = false.obs;

  static Future<void> initData(
      {required String id, required String uBy}) async {
    loadingData = true.obs;

    taskId = id;
    _uploadBy = uBy;
    loadingData = false.obs;
  }

  late DocumentSnapshot<Map<String, dynamic>> currentTaskData;
  void getCurrentTaskDetails() async {
    loadingData.value = true;
    currentTaskData = await FirebaseFirestore.instance
        .collection('tasks')
        .doc(TaskDetailsController.taskId)
        .get();
    log(currentTaskData.data()!['TaskCategory']);
    loadingData.value = false;
    update();
  }

  late DocumentSnapshot<Map<String, dynamic>> value;
  void getUploadedTaskUserDetails() async {
    try {
      loadingData = true.obs;
      value = await FirebaseFirestore.instance
          .collection('users')
          .doc(_uploadBy)
          .get();
    } catch (e) {
      log(e.toString());
    }
  }

  void checkBoxOnChange({required String uploadedBy}) async {
    if (currentTaskData.data()!['UploadedBy'] ==
        FirebaseAuth.instance.currentUser!.uid) {
      isTaskDone.value = true;
      log('Yes\n Task Status ${isTaskDone.toString()}');
      try {
        await FirebaseFirestore.instance.collection('tasks').doc(taskId).update(
          {'IsDone': true},
        );
      } catch (e) {
        log(e.toString());
      }
    } else {
      errorSnackBar(
        "You don't have the permission to make this taks done!",
      );
    }
  }

  var currentUser = FirebaseAuth.instance.currentUser;
  void makeComment({required String comment}) async {
    try {
      await FirebaseFirestore.instance.collection('tasks').doc(taskId).update(
        {
          'TaskComments': FieldValue.arrayUnion(
            [
              {
                'userId': _accountController.currentUserUid,
                'commentId': const Uuid().v4(),
                'commentBody': commentController.text,
                'time': Timestamp.now(),
                'UserName': _accountController.fullName,
                'UserImage': _accountController.imageUrl,
              }
            ],
          ),
        },
      );
    } catch (e) {
      log(e.toString());
    } finally {
      commentController.clear();
      isCommenting = false;
      update();
    }
  }

  void getDetailsOfUserWhoMakeAComment() async {
    FirebaseFirestore.instance.collection('users').doc();
  }

  @override
  void onInit() {
    getCurrentTaskDetails();
    getUploadedTaskUserDetails();
    super.onInit();
  }
}
