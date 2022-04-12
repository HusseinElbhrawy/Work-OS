import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/utils/const/const.dart';
import 'package:work_os/views/screens/add_task.dart';
import 'package:work_os/views/screens/all_workers.dart';
import 'package:work_os/views/screens/home.dart';
import 'package:work_os/views/widgets/custom_list_tile.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            title: 'All Tasks',
            onTap: () {
              Get.offAll(() => const HomeScreen());
            },
            icon: Icons.task_outlined,
          ),
          CustomListTile(
            title: 'My Account',
            onTap: () {},
            icon: Icons.settings_outlined,
          ),
          CustomListTile(
            title: 'Register Workers',
            onTap: () {
              Get.offAll(() => const AllWorkersScreen());
            },
            icon: Icons.workspaces_outline,
          ),
          CustomListTile(
            title: 'Add Tasks',
            onTap: () {
              Get.offAll(() => const AddTaskScreen());
            },
            icon: Icons.add_task_outlined,
          ),
          const Divider(color: kDarkBlue),
          CustomListTile(
            title: 'Logout',
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
                        'Sign Out',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: kDarkBlue,
                            ),
                      ),
                    ],
                  ),
                  content: Text(
                    'Do you wanna Sign Out?',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: kDarkBlue,
                        ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Log Out',
                        style: TextStyle(color: Colors.red),
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
