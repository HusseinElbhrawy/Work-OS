import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
