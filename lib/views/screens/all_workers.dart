import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/controller/all_worker_controller.dart';
import 'package:work_os/controller/home_controller.dart';
import 'package:work_os/controller/my_account_controller.dart';
import 'package:work_os/utils/const/const.dart';
import 'package:work_os/views/screens/my_account.dart';
import 'package:work_os/views/widgets/drawer_widget.dart';
import 'package:work_os/views/widgets/custom_dialog.dart';

class AllWorkersScreen extends StatelessWidget {
  const AllWorkersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AllWorkersController(), permanent: true);
    final HomeController homeController = Get.find();
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Workers',
          style: TextStyle(
            color: Colors.pink.shade800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              customDialog(
                deviceSize,
                list: homeController.tasksCategoryList,
              );
            },
            icon: Icon(
              Icons.filter_list_outlined,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
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
                return Card(
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
                          imageURl: controller.allWorkers[index]['ImageUrl'],
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
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: kDarkBlue,
                            fontWeight: FontWeight.bold,
                          ),
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
                    trailing:
                        controller.allWorkers[index]['Id'] == kCurrentUserUid
                            ? const SizedBox.shrink()
                            : IconButton(
                                onPressed: () {
                                  MyAccountController().openLink(
                                      url:
                                          'mailto:${controller.allWorkers[index]['Email']}');
                                },
                                icon: Icon(
                                  Icons.mail_outlined,
                                  size: 30,
                                  color: Colors.pink[800],
                                ),
                              ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
