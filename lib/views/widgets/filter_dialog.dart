import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> buildFilterDialog(Size deviceSize,
    {required List<String> tasksCategoryList}) {
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
          itemCount: tasksCategoryList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(
                Icons.check_circle_rounded,
                color: Colors.red[200],
              ),
              title: Text(tasksCategoryList[index]),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Closed'),
        ),
        TextButton(
          onPressed: () {
            //ToDo: cancel Filter Logic Here
          },
          child: const Text('Cancel Filter'),
        ),
      ],
    ),
  );
}
