import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:work_os/controller/style_controller.dart';
import 'package:work_os/utils/const/const.dart';
import 'package:work_os/utils/localization/local_controller.dart';
import 'package:work_os/utils/styles/theme.dart';
import 'package:work_os/views/screens/add_task.dart';
import 'package:work_os/views/screens/all_workers.dart';
import 'package:work_os/views/screens/home.dart';
import 'package:work_os/views/screens/my_account.dart';
import 'package:work_os/views/widgets/custom_list_tile.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalizationController localizatationController = Get.find();
    StyleController styleController = Get.find();

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
                    style: Get.isDarkMode
                        ? CustomDarkTheme.kmediumHeadline(context)
                        : CustomLightTheme.mediumHeadline(context),
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
              return CustomListTileSwith(
                iconData: Icons.language_outlined,
                title: 'change_lan'.tr,
                value: localizatationController.isArabic,
                onChange: (value) {
                  localizatationController.changeLanguage(
                    langKey: value == true ? 'ar' : 'en',
                    newValue: value,
                  );
                },
              );
            },
          ),
          CustomListTileSwith(
            iconData: Icons.color_lens,
            title: 'change_theme'.tr,
            value: styleController.isDarkTheme,
            onChange: (value) {
              final StyleController styleController = Get.find();
              styleController.changeTheme();
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
                        style: Theme.of(context)
                            .textTheme
                            .headline6 /* !.copyWith(
                              color: kDarkBlue,
                            ) */
                        ,
                      ),
                    ],
                  ),
                  content: Text(
                    'do_you_want_sign_out'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline6 /* !.copyWith(
                          color: kDarkBlue,
                        ) */
                    ,
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

class CustomListTileSwith extends StatelessWidget {
  const CustomListTileSwith({
    Key? key,
    required this.onChange,
    required this.value,
    required this.title,
    required this.iconData,
  }) : super(key: key);

  final Function(bool value) onChange;
  final bool value;
  final String title;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return ListTileSwitch(
      value: value,
      leading: Icon(
        iconData,
        color: Get.isDarkMode
            ? CustomDarkTheme.iconColor
            : CustomLightTheme.iconColor,
      ),
      onChanged: (value) => onChange(value),
      switchType: SwitchType.custom,
      switchActiveColor: Colors.indigo,
      title: Text(
        title,
        style: Get.isDarkMode
            ? CustomDarkTheme.smallHeadline(context)
            : CustomLightTheme.smallHeadline(context),
      ),
    );
  }
}
