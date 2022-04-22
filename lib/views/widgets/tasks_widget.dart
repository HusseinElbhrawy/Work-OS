import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/controller/home_controller.dart';
import 'package:work_os/controller/task_details_controller.dart';
import 'package:work_os/views/screens/task_details.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    Key? key,
    required this.index,
    required this.allData,
  }) : super(key: key);
  final int index;
  final Map allData;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        onTap: () async {
          TaskDetailsController.initData(
            id: allData['TaskID'],
            uBy: allData['UploadedBy'],
          );
          Get.to(() => const TaskDetailsScreen());
        },
        onLongPress: () {
          Get.dialog(
            AlertDialog(
              content: TextButton.icon(
                onPressed: () {
                  HomeController().deleteTask(id: allData['TaskID']);
                },
                icon: const Icon(Icons.delete),
                label: const Text('Remove'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.red),
                ),
              ),
            ),
          );
        },
        leading: Container(
          padding: const EdgeInsetsDirectional.only(end: 10),
          decoration: const BoxDecoration(
            border: BorderDirectional(
              end: BorderSide(
                width: 2,
                color: Colors.red,
              ),
            ),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.asset(
              allData['IsDone']
                  ? 'assets/images/check.png'
                  : 'assets/images/clock.png',
              color: allData['IsDone'] ? Colors.green.shade200 : null,
            ),
          ),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.keyboard_arrow_right),
        ),
        title: Text(
          allData['TaskTitle'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.linear_scale,
              color: Colors.pink.shade800,
            ),
            Text(
              allData['TaskCategory'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
