import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/models/message_model.dart';

class InnerChatController extends GetxController {
  late TextEditingController messageTextFormFiled;

  final FirebaseFirestore firebaseObject = FirebaseFirestore.instance;
  void sendMessage({required String message, required String sendTo}) async {
    await firebaseObject
        .collection('chats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chatWith')
        .doc(sendTo)
        .collection('messages')
        .add(
          MessageModel(
            messageContent: message,
            sendTo: sendTo,
            sendFrom: FirebaseAuth.instance.currentUser!.uid,
            timestamp: Timestamp.now(),
          ).toMap(),
        );
    messageTextFormFiled.clear();
  }

  @override
  void onInit() {
    messageTextFormFiled = TextEditingController();
    super.onInit();
  }
}
