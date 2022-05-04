import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/controller/inner_chat_controller.dart';
import 'package:work_os/views/screens/inner_chat/widgets/app_bar.dart';
import 'package:work_os/views/screens/inner_chat/widgets/empty_chat_wdiget.dart';
import 'package:work_os/views/screens/inner_chat/widgets/full_chat_widget.dart';
import 'package:work_os/views/widgets/loading_widget.dart';

class InnerCharScreen extends StatelessWidget {
  const InnerCharScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> userData = Get.arguments;
    log('sendTo $userData');
    InnerChatController.initData(id: userData['id']);
    return Scaffold(
      appBar: innerChatAppBar(
        imageUrl: userData['imageUrl'],
        name: userData['name'],
        id: userData['id'],
      ),
      //userData['id']
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .doc(userData['id'])
            .collection('chatWith')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('messages')
            .orderBy('timestamp')
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot<Map>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: ListView.builder(
                itemCount: 50,
                itemBuilder: (context, index) {
                  return const LoadingWidget();
                },
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something wrong!'),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return EmptyChatWidget(userData: userData);
          } else {
            log(snapshot.data!.docs[0].data()['sendFrom']);

            return FullChatWidget(
              userData: userData,
              snapshot: snapshot,
            );
          }
        },
      ),
    );
  }
}
