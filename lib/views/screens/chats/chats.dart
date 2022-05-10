import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/controller/style_controller.dart';
import 'package:work_os/utils/const/const.dart';
import 'package:work_os/views/screens/home/home.dart';
import 'package:work_os/views/widgets/zoom_drawer.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StyleController styleController = Get.find();
    return CustomZoomDrawer(
      child: Scaffold(
        appBar: AppBar(
          title: Text('chats_screen'.tr),
          leading: CustomLeadingButton(styleController: styleController),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats')
              .doc('TNzXflGuzLUYrkBAx03VSLQudsf2')
              .collection('chatWith')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            log(snapshot.data.docs.length.toString());
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const ChatScreenItemWidget();
              },
            );
          },
        ),
      ),
    );
  }
}

class ChatScreenItemWidget extends StatelessWidget {
  const ChatScreenItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (StyleController controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Card(
            color: controller.isDarkTheme ? kDarkModeItemColor : Colors.white,
            child: ListTile(
              contentPadding: const EdgeInsets.all(8),
              onTap: () {
                log('Tapped');
              },
              leading: const CircleAvatar(
                backgroundColor: Colors.red,
                backgroundImage: AssetImage('assets/images/man.png'),
                radius: 25,
              ),
              title: const Text('Name'),
              subtitle: const Text('Last Message'),
            ),
          ),
        );
      },
    );
  }
}
