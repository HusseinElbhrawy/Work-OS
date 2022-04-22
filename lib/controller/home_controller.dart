import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/views/widgets/snack_bar.dart';

class HomeController extends GetxController {
  late QuerySnapshot<Map<String, dynamic>> tasks;
  bool isLoading = false;
  void getAllTasks() async {
    isLoading = true;
    try {
      tasks = await FirebaseFirestore.instance.collection('tasks').get();
    } finally {
      isLoading = false;
      update();
    }
  }

  void listenToNewTasks() async {
    FirebaseFirestore.instance.collection('tasks').snapshots().listen(
      (event) {
        log(event.docs[2].data().toString());
      },
    );
  }

  void deleteTask({required String id}) async {
    Get.back();
    var value =
        await FirebaseFirestore.instance.collection('tasks').doc(id).get();

    if (FirebaseAuth.instance.currentUser!.uid ==
        value.data()!['UploadedBy'].toString()) {
      await FirebaseFirestore.instance.collection('tasks').doc(id).delete();
    } else {
      errorSnackBar('You can\'t delete this task!');
    }
  }

  String? filterdValue;
  final List<String> tasksCategoryList = [
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
          'Task Category',
          style: TextStyle(
            color: Colors.pink.shade600,
          ),
        ),
        content: SizedBox(
          width: Get.size.width / 1,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: tasksCategoryList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  filterdValue = tasksCategoryList[index];
                  update();

                  Get.back();
                },
                leading: Icon(
                  Icons.check_circle_rounded,
                  color: Colors.red[200],
                ),
                title: Text(tasksCategoryList[index]),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Closed'),
          ),
          TextButton(
            onPressed: () {
              filterdValue = null;
              update();
              Get.back();
            },
            child: const Text('Cancel Filter'),
          ),
        ],
      ),
    );
  }

  List filterTasks(
      {required String type, required Map<String, dynamic> allData}) {
    return allData.entries
        .where(
          (element) => element.value == type,
        )
        .toList();
  }

  // @override
  // void onInit() {
  //   getAllTasks();
  //   super.onInit();
  // }
}
