import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:work_os/controller/home_controller.dart';
import 'package:work_os/utils/const/const.dart';
import 'package:work_os/views/widgets/drawer_widget.dart';
import 'package:work_os/views/widgets/loading_widget.dart';
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
                return ListView.builder(
                  itemCount: 100,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) =>
                      const GFShimmer(
                    child: LoadingWidget(),
                  ),
                );
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
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 1200),
                      child: SlideAnimation(
                        horizontalOffset: 500,
                        child: FadeInAnimation(
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: TaskWidget(
                              index: index,
                              allData: snapshot.data!.docs[index].data(),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
