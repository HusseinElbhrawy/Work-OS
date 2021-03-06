import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:work_os/controller/style_controller.dart';
import 'package:work_os/utils/const/const.dart';
import 'package:work_os/utils/localization/local.dart';
import 'package:work_os/utils/localization/local_controller.dart';
import 'package:work_os/utils/services/user_status.dart';
import 'package:work_os/utils/styles/theme.dart';
import '/utils/binding/my_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends GetView<StyleController> {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocalizationController langConroller =
        Get.put(LocalizationController());
    final StyleController styleController = Get.put(
      StyleController(),
      permanent: true,
    );

    return GetBuilder(
      assignId: false,
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
          // home: const MyTestPage(),
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
            // text: '???????? ?????????? ??????????',
            textType: TextType.ColorizeAnimationText,
            textStyle: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: kDarkBlue, fontWeight: FontWeight.bold),
            backgroundColor: styleController.isDarkTheme
                ? const Color(0xff1E2336)
                : kScaffoldBGColor,
          ),
        );
      },
    );
  }
}
