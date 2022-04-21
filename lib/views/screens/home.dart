import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/controller/home_controller.dart';
import 'package:work_os/utils/const/const.dart';
import 'package:work_os/views/widgets/drawer_widget.dart';
import 'package:work_os/views/widgets/tasks_widget.dart';

import '../widgets/filter_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static int currentIndex = 0;
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
    final HomeController controller = Get.put(
      HomeController(),
      permanent: true,
    );
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: false,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: Text(
          'Task',
          style: TextStyle(
            color: Colors.pink.shade600,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              var value = await buildFilterDialog(
                deviceSize,
                list: tasksCategoryList,
                isHomeScreen: true,
              );
              log(value.toString());
            },
            icon: Icon(
              Icons.filter_list_outlined,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('tasks')
              .where('TaskCategory')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Something Error!',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'Empty',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              );
            } else {
              return RefreshIndicator(
                color: kDarkBlue,
                onRefresh: () async {},
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    currentIndex = index;
                    return TaskWidget(
                      index: index,
                      allData: snapshot.data!.docs[index].data(),
                    );
                  },
                ),
              );
            }
          }),
    );
  }
}
