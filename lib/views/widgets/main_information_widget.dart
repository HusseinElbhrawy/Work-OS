import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/utils/styles/theme.dart';

class MainInformationWidget extends StatelessWidget {
  const MainInformationWidget({
    Key? key,
    required this.title1,
    required this.title2,
  }) : super(key: key);
  final String title1, title2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            '$title1:',
            style: Get.isDarkMode
                ? CustomDarkTheme.kHeadline6(context)
                : CustomLightTheme.headline6(context),
          ),
          SizedBox(
            width: Get.width / 2.5,
            child: Text(
              title2,
              overflow: TextOverflow.ellipsis,
              style: Get.isDarkMode
                  ? CustomDarkTheme.bodyLarge(context)
                  : CustomLightTheme.bodyLarge(context),
            ),
          ),
        ],
      ),
    );
  }
}
