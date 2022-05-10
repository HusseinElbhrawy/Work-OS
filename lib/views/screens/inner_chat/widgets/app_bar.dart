import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/controller/style_controller.dart';

final StyleController styleController = Get.find();
PreferredSizeWidget innerChatAppBar({
  required String name,
  required String imageUrl,
  required String id,
}) {
  return AppBar(
    leadingWidth: 15,
    title: ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(name),
      subtitle: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('users').doc(id).snapshots(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          } else {
            return Text(snapshot.data['IsOnline'] ? 'Online' : '');
          }
        },
      ),
    ),
    actions: [
      Directionality(
        textDirection: TextDirection.ltr,
        child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert,
          ),
        ),
      ),
    ],
  );
}
