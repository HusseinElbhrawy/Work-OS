import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/views/screens/home.dart';
import 'package:work_os/views/widgets/drawer_widget.dart';

import '/utils/const/const.dart';
import '/views/widgets/add_task_screen_custom_widget.dart';
import '/views/widgets/custom_auth_button.dart';
import '/views/widgets/filter_dialog.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskCategoryController =
          TextEditingController(text: 'Task Category'),
      _taskTitleController = TextEditingController(),
      _taskDescriptionController = TextEditingController(),
      _deadlineDateController = TextEditingController(text: 'Pick up a date');

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    var spaceBetweenWidget = SizedBox(height: deviceSize.height / 30);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: kDarkBlue),
        elevation: 0.0,
      ),
      drawer: const DrawerWidget(),
      body: Form(
        key: _formKey,
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
                AddTaskScreenCustomWidget(
                  textEditingController: _taskCategoryController,
                  onTap: () async {
                    buildFilterDialog(
                      deviceSize,
                      tasksCategoryList: HomeScreen.tasksCategoryList,
                      categoryController: _taskCategoryController,
                    );
                  },
                  title: 'Task Category',
                  hint: '',
                  enabled: false,
                ),
                spaceBetweenWidget,
                AddTaskScreenCustomWidget(
                  textEditingController: _taskTitleController,
                  onTap: () {
                    print('Tapped');
                  },
                  title: 'Task Title',
                  hint: '',
                  maxLength: 100,
                ),
                spaceBetweenWidget,
                AddTaskScreenCustomWidget(
                  textEditingController: _taskDescriptionController,
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
                  textEditingController: _deadlineDateController,
                  onTap: () async {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    ).then((value) {
                      setState(() {
                        _deadlineDateController.text =
                            '${value!.year}/${value.month}/${value.day}';
                      });
                    }).catchError(
                      (error) {
                        Get.snackbar(
                          'Warning',
                          'Please Select a Date',
                          colorText: Colors.black,
                          backgroundColor: Colors.red.shade300,
                          onTap: (get) {},
                        );
                      },
                    );
                  },
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
                    if (_formKey.currentState!.validate()) {}
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
