import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AllWorkersController extends GetxController {
  RxBool isloading = false.obs;
  List allWorkers = [];
  void _getAllWorkers() async {
    try {
      isloading.value = true;
      final values = await FirebaseFirestore.instance.collection('users').get();
      for (var element in values.docs) {
        allWorkers.add(element);
      }
      isloading.value = false;
    } catch (e) {
      log(e.toString());
      isloading.value = false;
    }
  }

  @override
  void onInit() {
    _getAllWorkers();
    super.onInit();
  }
}
