import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalizationController extends GetxController {
  static final GetStorage _box = GetStorage();
  static bool isArabic = _box.read('lang') ?? false;

  Locale initialLang =
      _box.read('lang') == true ? const Locale('ar') : const Locale('en');

  void changeLanguage({required String langKey, required bool newValue}) async {
    Locale locale = Locale(langKey);
    isArabic = newValue;
    await _box.write('lang', isArabic);
    Get.updateLocale(locale);
  }
}
