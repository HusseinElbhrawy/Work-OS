import 'dart:developer';

import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:work_os/utils/styles/theme.dart';

class StyleController extends GetxController {
  static final GetStorage _box = GetStorage();

  bool isDarkTheme = _box.read('darkMode') ?? false;
  void changeTheme() async {
    if (isDarkTheme) {
      Get.changeTheme(kLighTheme);
      isDarkTheme = !isDarkTheme;
      await _box.write('darkMode', isDarkTheme);
      update();
    } else {
      Get.changeTheme(kDarkTheme);
      isDarkTheme = !isDarkTheme;
      await _box.write('darkMode', isDarkTheme);
      log(isDarkTheme.toString());
      update();
    }
  }

  final zoomDrawerController = ZoomDrawerController();

  void toggleDrawer() {
    print("Toggle drawer");
    zoomDrawerController.toggle?.call();
    update();
  }
}
