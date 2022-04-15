import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/views/screens/home.dart';
import 'package:work_os/views/widgets/filter_dialog.dart';

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
    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerWidget(),
      body: GetBuilder(
        init: AddTaskController(),
        builder: (AddTaskController addTaskController) => Form(
          key: addTaskController.formKey,
          child: Card(
            color: Colors.white,
            margin: const EdgeInsetsDirectional.only(start: 10, end: 10),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsetsDirectional.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: deviceSize.height / 40),
                  Text(
                    'Add Filed are required',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: kDarkBlue,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Divider(color: kDarkBlue),
                  Builder(builder: (context) {
                    return AddTaskScreenCustomWidget(
                      textEditingController:
                          addTaskController.taskCategoryController,
                      onTap: () {
                        buildFilterDialog(
                          deviceSize,
                          list: HomeScreen.tasksCategoryList,
                          categoryController:
                              addTaskController.taskCategoryController,
                          isHomeScreen: true,
                        );
                      },
                      title: 'Task Category',
                      hint: '',
                      enabled: false,
                    );
                  }),
                  spaceBetweenWidget,
                  AddTaskScreenCustomWidget(
                    textEditingController:
                        addTaskController.taskTitleController,
                    onTap: () {
                      print('Tapped');
                    },
                    title: 'Task Title',
                    hint: '',
                    maxLength: 100,
                  ),
                  spaceBetweenWidget,
                  AddTaskScreenCustomWidget(
                    textEditingController:
                        addTaskController.taskDescriptionController,
                    onTap: () {
                      print('Tapped');
                    },
                    title: 'Task Description',
                    hint: '',
                    maxLength: 1000,
                    maxLines: 5,
                  ),
                  spaceBetweenWidget,
                  AddTaskScreenCustomWidget(
                    textEditingController:
                        addTaskController.deadlineDateController,
                    onTap: () => addTaskController.customDatePicker(context),
                    title: 'Deadline Date',
                    hint: '',
                    enabled: false,
                  ),
                  spaceBetweenWidget,
                  CustomAuthButton(
                    title: 'Upload',
                    icon: Icons.upload,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (addTaskController.formKey.currentState!.validate()) {}
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
