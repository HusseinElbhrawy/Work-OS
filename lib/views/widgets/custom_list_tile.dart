import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/utils/styles/theme.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.title,
    required this.onTap,
    required this.icon,
  }) : super(key: key);
  final Function onTap;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(),
      leading: Icon(
        icon,
        color: Get.isDarkMode
            ? CustomDarkTheme.iconColor
            : CustomLightTheme.iconColor,
      ),
      title: Text(
        title,
        style: Get.isDarkMode
            ? CustomDarkTheme.smallHeadline(context)
            : CustomLightTheme.smallHeadline(context),
      ),
    );
  }
}
