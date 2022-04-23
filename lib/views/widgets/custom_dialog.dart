import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> customDialog(
  Size deviceSize, {
  required List<String> list,
  TextEditingController? categoryController,
  TextEditingController? companyPositionController,
  bool isHomeScreen = false,
}) {
  return Get.dialog(
    AlertDialog(
      title: Text(
        'Task Category',
        style: TextStyle(
          color: Colors.pink.shade600,
        ),
      ),
      content: SizedBox(
        width: deviceSize.width / 1,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: list.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: isHomeScreen
                  ? () {
                      categoryController!.text = list[index];
                      log(list[index].toString());

                      Get.back();
                    }
                  : () {
                      companyPositionController!.text = list[index];
                      log(list[index].toString());

                      Get.back();
                    },
              leading: Icon(
                Icons.check_circle_rounded,
                color: Colors.red[200],
              ),
              title: Text(list[index]),
            );
          },
        ),
      ),
    ),
  );
}
