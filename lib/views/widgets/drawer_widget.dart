import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:work_os/utils/const/const.dart';
import 'package:work_os/utils/localization/local_controller.dart';
import 'package:work_os/views/screens/add_task.dart';
import 'package:work_os/views/screens/all_workers.dart';
import 'package:work_os/views/screens/home.dart';
import 'package:work_os/views/screens/my_account.dart';
import 'package:work_os/views/widgets/custom_list_tile.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalizationController localizatationController = Get.find();

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue.shade100),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const FlutterLogo(size: 40),
                  Text(
                    'Work OS',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: kDarkBlue,
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          CustomListTile(
            title: 'all_tasks'.tr,
            onTap: () {
              Get.offAll(() => const HomeScreen());
            },
            icon: Icons.task_outlined,
          ),
          CustomListTile(
            title: 'my_account'.tr,
            onTap: () {
              Get.offAll(() => const MyAccountScreen(
                    comeFromAllWorkerScreen: false,
                  ));
            },
            icon: Icons.settings_outlined,
          ),
          CustomListTile(
            title: 'register_workers'.tr,
            onTap: () {
              Get.offAll(() => const AllWorkersScreen());
            },
            icon: Icons.workspaces_outline,
          ),
          CustomListTile(
            title: 'add_task'.tr,
            onTap: () {
              Get.offAll(() => const AddTaskScreen());
            },
            icon: Icons.add_task_outlined,
          ),
          GetBuilder(
            builder: (LocalizationController controller) {
              return ListTileSwitch(
                value: LocalizationController.isArabic,
                leading: const Icon(
                  Icons.language_outlined,
                  color: kDarkBlue,
                ),
                onChanged: (value) {
                  localizatationController.changeLanguage(
                    langKey: value == true ? 'ar' : 'en',
                    newValue: value,
                  );
                },
                switchType: SwitchType.custom,
                switchActiveColor: Colors.indigo,
                title: Text(
                  'change_lan'.tr,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: kDarkBlue,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              );
            },
          ),
          const Divider(color: kDarkBlue),
          CustomListTile(
            title: 'log_out'.tr,
            onTap: () {
              Get.dialog(
                AlertDialog(
                  title: Row(
                    children: [
                      const Icon(
                        Icons.logout_outlined,
                        color: kDarkBlue,
                      ),
                      const VerticalDivider(color: Colors.transparent),
                      Text(
                        'log_out'.tr,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: kDarkBlue,
                            ),
                      ),
                    ],
                  ),
                  content: Text(
                    'do_you_want_sign_out'.tr,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: kDarkBlue,
                        ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('cancel2'.tr),
                    ),
                    TextButton(
                      onPressed: () => logOut(),
                      child: Text(
                        'log_out'.tr,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: Icons.logout_outlined,
          ),
        ],
      ),
    );
  }
}
