import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:work_os/controller/home_controller.dart';
import 'package:work_os/controller/my_account_controller.dart';
import 'package:work_os/controller/style_controller.dart';
import 'package:work_os/utils/const/const.dart';
import 'package:work_os/utils/styles/theme.dart';
import 'package:work_os/views/widgets/loading_widget.dart';
import 'package:work_os/views/widgets/tasks_widget.dart';
import 'package:work_os/views/widgets/zoom_drawer.dart';

class HomeScreen extends GetView<StyleController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(
      HomeController(),
      permanent: true,
    );
    homeController.makeCurrentUserOnline();
    final StyleController styleController = Get.find();
    Get.put(
      MyAccountController(),
      permanent: true,
    );
    return CustomZoomDrawer(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          leading: CustomLeadingButton(styleController: styleController),
          title: Text('tasks'.tr),
          actions: [
            IconButton(
              onPressed: () async => homeController.showfilterDialog(),
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
                      style: styleController.isDarkTheme
                          ? CustomDarkTheme.headline6(context)
                          : CustomLightTheme.headline6(context),
                    ),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Container(
                    margin: const EdgeInsets.all(25),
                    child: ListView(
                      children: [
                        Image.asset(
                          'assets/images/empty.png',
                          color: styleController.isDarkTheme
                              ? Colors.white
                              : kDarkBlue,
                        ),
                        Center(
                          child: Text(
                            'no_tasks'.tr,
                            style: styleController.isDarkTheme
                                ? CustomDarkTheme.smallHeadline(context)
                                : CustomLightTheme.smallHeadline(context),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      homeController.refresh();
                    },
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      physics: const AlwaysScrollableScrollPhysics(),
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
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class CustomLeadingButton extends StatelessWidget {
  const CustomLeadingButton({
    Key? key,
    required this.styleController,
  }) : super(key: key);

  final StyleController styleController;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: styleController.toggleDrawer,
      icon: const Icon(Icons.menu),
    );
  }
}
