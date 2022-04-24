import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/controller/home_controller.dart';
import 'package:work_os/utils/styles/theme.dart';
import 'package:work_os/views/widgets/custom_dialog.dart';

import '/controller/add_task_controller.dart';
import '/utils/const/const.dart';
import '/views/widgets/add_task_screen_custom_widget.dart';
import '/views/widgets/custom_auth_button.dart';
import '/views/widgets/drawer_widget.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    var spaceBetweenWidget = SizedBox(height: deviceSize.height / 30);
    final HomeController homeController = Get.find();
    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerWidget(),
      body: GetBuilder(
        init: AddTaskController(),
        builder: (AddTaskController addTaskController) => Form(
          key: addTaskController.formKey,
          child: Card(
            color: Get.isDarkMode
                ? const Color.fromARGB(255, 35, 43, 65)
                : Colors.white,
            margin: const EdgeInsetsDirectional.only(start: 10, end: 10),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsetsDirectional.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: deviceSize.height / 40),
                  Text(
                    'all_filed_are_required'.tr,
                    style: Get.isDarkMode
                        ? CustomDarkTheme.smallHeadline(context)
                        : CustomLightTheme.smallHeadline(context),
                  ),
                  const Divider(color: kDarkBlue),
                  Builder(builder: (context) {
                    return AddTaskScreenCustomWidget(
                      textEditingController:
                          addTaskController.taskCategoryController,
                      onTap: () {
                        customDialog(
                          deviceSize,
                          list: homeController.tasksCategoryListToFilterd,
                          categoryController:
                              addTaskController.taskCategoryController,
                          isHomeScreen: true,
                        );
                      },
                      title: 'task_category'.tr,
                      hint: '',
                      enabled: false,
                    );
                  }),
                  spaceBetweenWidget,
                  AddTaskScreenCustomWidget(
                    textEditingController:
                        addTaskController.taskTitleController,
                    onTap: () {},
                    title: 'task_title'.tr,
                    hint: '',
                    maxLength: 100,
                  ),
                  spaceBetweenWidget,
                  AddTaskScreenCustomWidget(
                    textEditingController:
                        addTaskController.taskDescriptionController,
                    onTap: () {},
                    title: 'task_description'.tr,
                    hint: '',
                    maxLength: 1000,
                    maxLines: 5,
                  ),
                  spaceBetweenWidget,
                  AddTaskScreenCustomWidget(
                    textEditingController:
                        addTaskController.deadlineDateController,
                    onTap: () => addTaskController.customDatePicker(context),
                    title: 'deadline_date'.tr,
                    hint: '',
                    enabled: false,
                  ),
                  spaceBetweenWidget,
                  GetX(
                    builder: (AddTaskController controller) {
                      return controller.isTaskUploading.value
                          ? const Center(
                              child: LinearProgressIndicator(),
                            )
                          : CustomAuthButton(
                              title: 'upload'.tr,
                              icon: Icons.upload,
                              onTap: () {
                                FocusScope.of(context).unfocus();

                                if (addTaskController.formKey.currentState!
                                    .validate()) {
                                  controller.uploadTask();
                                }
                              },
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
