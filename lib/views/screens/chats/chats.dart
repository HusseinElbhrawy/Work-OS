import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/controller/style_controller.dart';
import 'package:work_os/utils/const/const.dart';
import 'package:work_os/views/widgets/drawer_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: Text('chats_screen'.tr),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const ChatScreenItemWidget();
        },
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
      builder: (StyleController controller) => Padding(
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
      ),
    );
  }
}
