import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/controller/home_controller.dart';
import 'package:work_os/controller/style_controller.dart';
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
        title: Text('tasks'.tr),
        actions: [
          IconButton(
            onPressed: () async => controller.showfilterDialog(),
            icon: const Icon(Icons.filter_list_outlined),
          ),
        ],
      ),
      body: GetBuilder(
        builder: (HomeController controller) {
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('tasks')
                  .where(
                    'TaskCategory',
                    isEqualTo: controller.filterdValue1,
                  )
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot<Map>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'something_error'.tr,
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
                          'no_tasks'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: kDarkBlue),
                        ),
                      ],
                    ),
                  );
                } else {
                  return StatefulBuilder(
                    builder: (BuildContext context,
                            void Function(void Function()) setState) =>
                        ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        setState() => () {
                              final StyleController styleController =
                                  Get.find();
                              styleController.changeTheme();
                            };

                        return Directionality(
                          textDirection: TextDirection.ltr,
                          child: TaskWidget(
                            index: index,
                            allData: snapshot.data!.docs[index].data(),
                          ),
                        );
                      },
                    ),
                  );
                }
              });
        },
      ),
    );
  }
}
