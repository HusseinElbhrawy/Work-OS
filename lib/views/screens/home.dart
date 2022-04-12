import 'package:flutter/material.dart';
import 'package:work_os/utils/const/const.dart';
import 'package:work_os/views/widgets/drawer_widget.dart';
import 'package:work_os/views/widgets/tasks_widget.dart';

import '../widgets/filter_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static final List<String> tasksCategoryList = [
    'Business',
    'Programming',
    'Information Technology',
    'Human Resources',
    'Marketing',
    'Design',
    'Accounting',
  ];
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: false,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey.shade900),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        title: Text(
          'Task',
          style: TextStyle(
            color: Colors.pink.shade600,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              buildFilterDialog(
                deviceSize,
                tasksCategoryList: tasksCategoryList,
              );
            },
            icon: Icon(
              Icons.filter_list_outlined,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: kDarkBlue,
        onRefresh: () async {
          print(
            'Refreshed',
          );
        },
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return const TaskWidget();
          },
        ),
      ),
    );
  }
}
