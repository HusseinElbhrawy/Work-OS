import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:get_storage/get_storage.dart';
import 'package:work_os/controller/style_controller.dart';
import 'package:work_os/utils/localization/local.dart';
import 'package:work_os/utils/localization/local_controller.dart';
import 'package:work_os/utils/styles/theme.dart';
import '/utils/binding/my_binding.dart';
import '/utils/const/const.dart';
import '/utils/services/user_status.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocalizationController langConroller =
        Get.put(LocalizationController());
    final StyleController styleController = Get.put(StyleController());
    return GetBuilder(
      builder: (StyleController controller) {
        return GetMaterialApp(
          initialBinding: MyBinding(),
          debugShowCheckedModeBanner: false,
          locale: langConroller.initialLang,
          translations: MyLocalization(),
          title: 'Work OS',
          theme: kLighTheme,
          darkTheme: kDarkTheme,
          themeMode: controller.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          home: SplashScreenView(
            navigateRoute: FutureBuilder(
              future: Firebase.initializeApp(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text(
                        'something_error'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: kDarkBlue,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  );
                }
                return UserStatus().page;
              },
            ),
            imageSrc: "assets/images/working.png",
            text: "Work OS",
            // text: 'نظام تشغيل العمل',
            textType: TextType.ColorizeAnimationText,
            textStyle: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: kDarkBlue, fontWeight: FontWeight.bold),
            backgroundColor: kScaffoldBGColor,
          ),
        );
      },
    );
  }
}
