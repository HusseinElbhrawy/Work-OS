import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/views/widgets/snack_bar.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> opacity;
  late Animation<Offset> position;

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
    opacity =
        CurvedAnimation(parent: animationController, curve: Curves.easeInQuad);
    position =
        Tween<Offset>(begin: const Offset(-5, 0), end: const Offset(0, 0))
            .animate(animationController);
    super.onInit();
  }

  void deleteTask({required String id}) async {
    Get.back();
    var value =
        await FirebaseFirestore.instance.collection('tasks').doc(id).get();

    if (FirebaseAuth.instance.currentUser!.uid ==
        value.data()!['UploadedBy'].toString()) {
      await FirebaseFirestore.instance.collection('tasks').doc(id).delete();
    } else {
      errorSnackBar('you_can_not_delete_this_task'.tr);
    }
  }

  String? filterdValue1;
  final List<String> tasksCategoryListToFilterd = [
    'Business',
    'Programming',
    'Information Technology',
    'Human Resources',
    'Marketing',
    'Design',
    'Accounting',
  ];

  Future<void> showfilterDialog() async {
    return Get.dialog(
      AlertDialog(
        title: Text(
          'task_category'.tr,
          style: TextStyle(
            color: Get.isDarkMode ? Colors.white : Colors.pink.shade600,
          ),
        ),
        content: SizedBox(
          width: Get.size.width / 1,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: tasksCategoryListToFilterd.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  filterdValue1 = tasksCategoryListToFilterd[index];

                  log(filterdValue1.toString());
                  update();

                  Get.back();
                },
                leading: Icon(
                  Icons.check_circle_rounded,
                  color: Colors.red[200],
                ),
                title: Text(tasksCategoryListToFilterd[index]),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'cancel'.tr,
              style: TextStyle(
                color: Get.isDarkMode ? Colors.white : Colors.blue,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              filterdValue1 = null;
              update();
              Get.back();
            },
            child: Text(
              'cancel_filter'.tr,
              style: TextStyle(
                color: Get.isDarkMode ? Colors.white : Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
