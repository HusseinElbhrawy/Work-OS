import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget innerChatAppBar({
  required String name,
  required String imageUrl,
  required String id,
}) {
  return AppBar(
    leadingWidth: 15,
    leading: IconButton(
      padding: const EdgeInsets.all(16),
      onPressed: () {
        Get.back();
      },
      icon: const Icon(
        Icons.arrow_back_ios,
      ),
    ),
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
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.more_vert,
        ),
      ),
    ],
  );
}
