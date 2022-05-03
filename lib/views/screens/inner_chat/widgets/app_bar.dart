import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget innerChatAppBar({
  required String name,
  required String imageUrl,
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
      subtitle: const Text('Online'),
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
