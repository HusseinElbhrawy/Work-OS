import 'package:get/get.dart';
import 'package:work_os/utils/localization/local_controller.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LocalizationController());
  }
}
