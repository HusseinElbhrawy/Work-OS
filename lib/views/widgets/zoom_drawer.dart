import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:work_os/controller/my_account_controller.dart';
import 'package:work_os/controller/style_controller.dart';
import 'package:work_os/utils/const/const.dart';
import 'package:work_os/utils/localization/local_controller.dart';
import 'package:work_os/utils/styles/theme.dart';
import 'package:work_os/views/screens/add_task/add_task.dart';
import 'package:work_os/views/screens/all_workers/all_workers.dart';
import 'package:work_os/views/screens/chats/chats.dart';
import 'package:work_os/views/screens/home/home.dart';
import 'package:work_os/views/screens/inner_chat/widgets/app_bar.dart';
import 'package:work_os/views/screens/my_account/my_account.dart';
import 'package:work_os/views/widgets/custom_list_tile.dart';
import 'package:work_os/views/widgets/custom_list_tile_widget.dart';

class CustomZoomDrawer extends StatelessWidget {
  const CustomZoomDrawer({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final StyleController styleController = Get.find();
    final LocalizationController localizationController = Get.find();

    return GetBuilder(
      builder: (StyleController controller) {
        return ZoomDrawer(
          menuBackgroundColor:
              controller.isDarkTheme ? const Color(0xff171D2D) : Colors.white,
          controller: styleController.zoomDrawerController,
          borderRadius: 24.0,
          showShadow: true,
          isRtl: localizationController.isArabic,
          angle: -5.0,
          drawerShadowsBackgroundColor: Colors.grey,
          slideWidth: MediaQuery.of(context).size.width * 0.75,
          menuScreen: const MenuScreen(),
          mainScreen: child,
        );
      },
    );
  }
}

class MenuScreen extends GetView<StyleController> {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: ListView(
        children: [
          GetBuilder(
            init: MyAccountController(),
            builder: (MyAccountController controller) {
              return DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue.shade100),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundImage: controller.imageUrl != null
                            ? NetworkImage(controller.imageUrl.toString())
                            : const AssetImage('assets/images/man.png')
                                as ImageProvider,
                        radius: 45,
                      ),
                      Text(
                        controller.fullName.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: Get.isDarkMode
                            ? CustomDarkTheme.smallHeadline(context)
                            : CustomLightTheme.smallHeadline(context),
                      ),
                    ],
                  ),
                ),
              );
            },
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
          CustomListTile(
            title: 'chats_screen'.tr,
            onTap: () {
              Get.offAll(() => const ChatScreen());
            },
            icon: Icons.chat,
          ),
          GetBuilder(
            builder: (LocalizationController controller) {
              return CustomListTileSwith(
                iconData: Icons.language_outlined,
                title: 'change_lan'.tr,
                value: controller.isArabic,
                onChange: (value) {
                  controller.changeLanguage(
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
          Card(
            color: Colors.red,
            child: CustomListTile(
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
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                    content: Text(
                      'do_you_want_sign_out'.tr,
                      style: Theme.of(context).textTheme.headline6,
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
          ),
        ],
      ),
    );
  }
}
