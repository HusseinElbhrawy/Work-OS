import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:work_os/utils/styles/theme.dart';

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
            ? CustomDarkTheme.headline6(context)
            : CustomLightTheme.headline6(context),
      ),
    );
  }
}
