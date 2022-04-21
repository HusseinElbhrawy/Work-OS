import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/controller/my_account_controller.dart';
import 'package:work_os/controller/task_details_controller.dart';
import 'package:work_os/utils/const/const.dart';
import 'package:work_os/views/widgets/add_task_screen_custom_widget.dart';
import 'package:work_os/views/widgets/profile_picture.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskDetailsController _taskDetailsController =
        Get.put(TaskDetailsController(), permanent: false);
    final MyAccountController _myAccountController =
        Get.put(MyAccountController(), permanent: true);
    TaskDetailsController().profileBorderColor.shuffle();

    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: GetX(
        builder: (TaskDetailsController controller) {
          if (controller.loadingData.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            _taskDetailsController.isTaskDone.value =
                controller.currentTaskData.data()!['IsDone'];
            return Form(
              key: _taskDetailsController.formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Develop an App',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: kDarkBlue,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const CustomText(title: 'Uploaded By'),
                                const Spacer(),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: Row(
                                    children: [
                                      ProfilePicture(
                                        deviceSize: deviceSize,
                                        imageURL: _taskDetailsController.value
                                            .data()!['ImageUrl'],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(_taskDetailsController.value
                                              .data()!['Name']),
                                          Text(_taskDetailsController.value
                                              .data()!['PositionInCompany']),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Divider(color: kDarkBlue),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(title: 'Uploaded on:'),
                                CustomText(
                                    title:
                                        '${controller.currentTaskData.data()!['CreatedAt'].toDate().year.toString()}/${controller.currentTaskData.data()!['CreatedAt'].toDate().month.toString()}/${controller.currentTaskData.data()!['CreatedAt'].toDate().day.toString()}'),
                              ],
                            ),
                            const Divider(color: Colors.transparent),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(title: 'Deadline date:'),
                                CustomText(
                                    title: controller.currentTaskData
                                        .data()!['DeadlineDate'],
                                    isDeadlineDate: true),
                              ],
                            ),
                            const Divider(color: Colors.transparent),
                            // Center(
                            //   child: !controller.currentTaskData
                            //           .data()!['CreatedAt']
                            //           .toDate()
                            //           .isAfter(DateTime.now())
                            //       ? const Text(
                            //           'Still Have Enough Time✅',
                            //           style: TextStyle(
                            //             color: Colors.green,
                            //           ),
                            //         )
                            //       : const Text(
                            //           'No Time Left ❌',
                            //           style: TextStyle(
                            //             color: Colors.red,
                            //           ),
                            //         ),
                            // ),
                            const Divider(color: kDarkBlue),
                            const CustomText(title: 'Done Status'),
                            Row(
                              children: [
                                const Text('Done'),
                                GetX(
                                  builder: (TaskDetailsController controller) {
                                    return Checkbox(
                                      fillColor: controller.isTaskDone.value
                                          ? MaterialStateProperty.all(
                                              Colors.green)
                                          : MaterialStateProperty.all(
                                              Colors.red),
                                      onChanged: (bool? value) =>
                                          controller.checkBoxOnChange(
                                              uploadedBy: controller
                                                  .currentTaskData
                                                  .data()!['UploadedBy']),
                                      value: controller.isTaskDone.value,
                                    );
                                  },
                                ),
                              ],
                            ),
                            const Divider(color: kDarkBlue),
                            const CustomText(title: 'Task Description'),
                            Text(controller.currentTaskData
                                .data()!['TaskDescription']),
                            ListTile(
                              leading: CircleAvatar(
                                radius: 23,
                                backgroundColor: Colors.red,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                    _myAccountController.imageUrl,
                                  ),
                                ),
                              ),
                              title: Text(_myAccountController.fullName),
                              subtitle:
                                  Text(_myAccountController.positionInCompany),
                            ),
                            Center(
                              child: GetBuilder(
                                init: TaskDetailsController(),
                                builder: (TaskDetailsController controller) {
                                  return AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 500),
                                    child: controller.isCommenting
                                        ? Row(
                                            children: [
                                              Expanded(
                                                child:
                                                    AddTaskScreenCustomWidget(
                                                  onTap: () {},
                                                  title: 'Comment',
                                                  hint: 'Comment',
                                                  textEditingController:
                                                      _taskDetailsController
                                                          .commentController,
                                                  maxLines: 5,
                                                  maxLength: 1000,
                                                ),
                                                flex: 3,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      MaterialButton(
                                                        onPressed: () {
                                                          FocusScope.of(context)
                                                              .unfocus();

                                                          if (_taskDetailsController
                                                              .formKey
                                                              .currentState!
                                                              .validate()) {
                                                            _taskDetailsController
                                                                .makeComment(
                                                              comment:
                                                                  _taskDetailsController
                                                                      .commentController
                                                                      .text,
                                                            );
                                                          }
                                                        },
                                                        child:
                                                            const Text('Post'),
                                                        textColor: Colors.white,
                                                        color: Colors
                                                            .pink.shade800,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                      ),
                                                      MaterialButton(
                                                        onPressed: () => controller
                                                            .toggleBetweenIsComment(),
                                                        child: const Text(
                                                            'Cancel'),
                                                        textColor: Colors.red,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            color: Colors.pink.shade800,
                                            textColor: Colors.white,
                                            onPressed: () => controller
                                                .toggleBetweenIsComment(),
                                            child: const Text(
                                              'Add a comment',
                                            ),
                                          ),
                                  );
                                },
                              ),
                            ),
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('tasks')
                                  .doc(TaskDetailsController.taskId)
                                  .snapshots(),
                              builder:
                                  (context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(
                                    'Something Error!',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  );
                                }

                                return ListView.builder(
                                  reverse: true,
                                  itemCount:
                                      snapshot.data['TaskComments'].length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: CircleAvatar(
                                        radius: 23,
                                        backgroundColor: TaskDetailsController()
                                            .profileBorderColor
                                            .elementAt(0),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          backgroundImage: NetworkImage(snapshot
                                              .data['TaskComments'][index]
                                                  ['UserImage']
                                              .toString()),
                                        ),
                                      ),
                                      title: Text(snapshot.data['TaskComments']
                                          [index]['UserName']),
                                      subtitle: Text(
                                        snapshot.data['TaskComments'][index]
                                            ['commentBody'],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.title,
    this.isDeadlineDate = false,
  }) : super(key: key);
  final String title;
  final bool isDeadlineDate;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline6?.copyWith(
            color: isDeadlineDate ? Colors.red : kDarkBlue,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
/*
controller.currentTaskData
                                      .data()!['CreatedAt']
                                      .toDate()
                                      .isBefore(DateTime.now())*/