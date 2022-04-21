import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAccountController extends GetxController {
  RxBool isLoading = false.obs;

  late String fullName, email, phoneNumber, imageUrl, positionInCompany;

  late bool isTheSameUser;
  late Timestamp date;

  void openLink({required String url}) async {
    if (!await launch(url)) throw "Error occurred couldn't open link";
  }

  final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  void _getUserData() async {
    isLoading.value = true;
    try {
      var value = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserUid)
          .get();
      fullName = value['Name'];
      date = value['CreatedAt'];
      email = value['Email'];
      imageUrl = value['ImageUrl'];
      phoneNumber = value['PhoneNumber'];
      positionInCompany = value['PositionInCompany'];
      isTheSameUser = value['Id'] == currentUserUid ? true : false;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      log(e.toString());
    }
  }

  @override
  void onInit() {
    _getUserData();
    super.onInit();
  }
}
