import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/controller/all_worker_controller.dart';
import 'package:work_os/controller/home_controller.dart';
import 'package:work_os/utils/const/const.dart';
import 'package:work_os/utils/styles/theme.dart';
import 'package:work_os/views/screens/inner_chat/inner_chat.dart';
import 'package:work_os/views/screens/my_account/my_account.dart';
import 'package:work_os/views/widgets/drawer_widget.dart';

class AllWorkersScreen extends StatelessWidget {
  const AllWorkersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AllWorkersController(), permanent: true);
    final HomeController homeController = Get.find();
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('all_workers'.tr)),
      drawer: const DrawerWidget(),
      body: GetX(
        builder: (AllWorkersController controller) {
          if (controller.isloading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: controller.allWorkers.length,
              itemBuilder: (context, index) {
                return Builder(builder: (context) {
                  return Directionality(
                    textDirection: TextDirection.ltr,
                    child: Card(
                      color: Get.isDarkMode
                          ? const Color.fromARGB(255, 35, 43, 65)
                          : Colors.white,
                      margin: const EdgeInsetsDirectional.all(4),
                      child: ListTile(
                        onTap: () {
                          Get.to(
                            () => MyAccountScreen(
                              comeFromAllWorkerScreen: true,
                              date: controller.allWorkers[index]['CreatedAt'],
                              email: controller.allWorkers[index]['Email'],
                              name: controller.allWorkers[index]['Name'],
                              phoneNumber: controller.allWorkers[index]
                                  ['PhoneNumber'],
                              postionInCompany: controller.allWorkers[index]
                                  ['PositionInCompany'],
                              id: controller.allWorkers[index]['Id'],
                              imageURl: controller.allWorkers[index]
                                  ['ImageUrl'],
                            ),
                          );
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        leading: Container(
                          decoration: const BoxDecoration(
                            border: BorderDirectional(
                              end: BorderSide(color: kDarkBlue, width: 2),
                            ),
                          ),
                          child: Container(
                            margin: const EdgeInsetsDirectional.only(end: 10),
                            child: Image.network(
                              controller.allWorkers[index]['ImageUrl'],
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        title: Text(
                          controller.allWorkers[index]['Name'],
                          style: Get.isDarkMode
                              ? CustomDarkTheme.headline6(context)
                              : CustomLightTheme.headline6(context),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.linear_scale,
                              color: Colors.pink.shade800,
                            ),
                            Text(
                              controller.allWorkers[index]['PositionInCompany'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        trailing: controller.allWorkers[index]['Id'] ==
                                kCurrentUserUid
                            ? const SizedBox.shrink()
                            : IconButton(
                                onPressed: () {
                                  log(controller.allWorkers[index]['Id']);
                                  Get.to(
                                    () => const InnerCharScreen(),
                                    arguments: {
                                      'id': controller.allWorkers[index]['Id'],
                                      'name': controller.allWorkers[index]
                                          ['Name'],
                                      'imageUrl': controller.allWorkers[index]
                                          ['ImageUrl'],
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.mail_outlined,
                                  size: 30,
                                  color: Colors.pink[800],
                                ),
                              ),
                      ),
                    ),
                  );
                });
              },
            );
          }
        },
      ),
    );
  }
}
