import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/controller/home_controller.dart';
import 'package:work_os/utils/const/const.dart';
import 'package:work_os/views/widgets/drawer_widget.dart';
import 'package:work_os/views/widgets/tasks_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(
      HomeController(),
      permanent: true,
    );
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
              await controller.showfilterDialog();
              log(controller.filterdValue.toString());
            },
            icon: Icon(
              Icons.filter_list_outlined,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
      body: GetBuilder(
        builder: (HomeController controller) => StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('tasks')
                .where('TaskCategory', isEqualTo: controller.filterdValue)
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
                return Container(
                  margin: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/empty.png',
                        color: kDarkBlue,
                      ),
                      Text(
                        'No Tasks!',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: kDarkBlue),
                      ),
                    ],
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
                      return TaskWidget(
                        index: index,
                        allData: snapshot.data!.docs[index].data(),
                      );
                    },
                  ),
                );
              }
            }),
      ),
    );
  }
}
