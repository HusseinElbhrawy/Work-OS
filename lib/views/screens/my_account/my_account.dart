import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/controller/my_account_controller.dart';
import 'package:work_os/utils/styles/theme.dart';
import 'package:work_os/views/widgets/custom_auth_button.dart';

import '/utils/const/const.dart';
import '/views/widgets/drawer_widget.dart';
import '/views/widgets/main_information_widget.dart';
import '/views/widgets/profile_picture.dart';
import '/views/widgets/social_button.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({
    Key? key,
    this.date,
    this.email,
    this.name,
    this.phoneNumber,
    this.postionInCompany,
    this.id,
    this.imageURl,
    required this.comeFromAllWorkerScreen,
  }) : super(key: key);
  final String? name, postionInCompany, email, phoneNumber, id, imageURl;
  final Timestamp? date;
  final bool comeFromAllWorkerScreen;
  @override
  Widget build(BuildContext context) {
    Get.put(MyAccountController(), permanent: true);
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerWidget(),
      body: GetX(
        builder: (MyAccountController controller) {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    color: Get.isDarkMode
                        ? const Color.fromARGB(255, 35, 43, 65)
                        : Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? deviceSize.height / 2
                              : deviceSize.height / 8,
                        ),
                        Text(
                          comeFromAllWorkerScreen
                              ? name.toString()
                              : controller.fullName.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: Get.isDarkMode
                              ? CustomDarkTheme.headline6(context)
                              : CustomLightTheme.headline6(context),
                        ),
                        Text(
                          comeFromAllWorkerScreen
                              ? '${postionInCompany.toString()} Since ${date?.toDate().year} - ${date?.toDate().month} - ${date?.toDate().day}'
                              : '${controller.positionInCompany.toString()} Since ${controller.date.toDate().year} - ${controller.date.toDate().month} - ${controller.date.toDate().day}',
                          style: Get.isDarkMode
                              ? CustomDarkTheme.headline6(context)
                              : CustomLightTheme.headline6(context),
                        ),
                        const Divider(color: kDarkBlue),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MainInformationWidget(
                              title1: 'contact_info'.tr,
                              title2: '',
                            ),
                            MainInformationWidget(
                              title1: 'email'.tr,
                              title2: comeFromAllWorkerScreen
                                  ? email.toString()
                                  : controller.email.toString(),
                            ),
                            MainInformationWidget(
                              title1: 'phone_number'.tr,
                              title2: comeFromAllWorkerScreen
                                  ? phoneNumber.toString()
                                  : controller.phoneNumber,
                            ),
                            (comeFromAllWorkerScreen &&
                                        controller.currentUserUid == id) ||
                                    (comeFromAllWorkerScreen == false &&
                                        controller.isTheSameUser)
                                ? const SizedBox.shrink()
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SocialButton(
                                          iconColor: Colors.green,
                                          iconData: Icons.whatsapp_outlined,
                                          onTap: () {
                                            MyAccountController().openLink(
                                              url: comeFromAllWorkerScreen
                                                  ? 'https://wa.me/$phoneNumber?text= Hello There'
                                                  : 'https://wa.me/${controller.phoneNumber}?text= Hello There',
                                            );
                                          },
                                        ),
                                        SocialButton(
                                          iconColor: Colors.red,
                                          iconData: Icons.mail_outlined,
                                          onTap: () {
                                            MyAccountController().openLink(
                                                url: comeFromAllWorkerScreen
                                                    ? 'mailto:$email'
                                                    : 'mailto:${controller.email.toString()}');
                                          },
                                        ),
                                        SocialButton(
                                          iconColor: Colors.purple,
                                          iconData: Icons.call_outlined,
                                          onTap: () {
                                            MyAccountController().openLink(
                                                url: comeFromAllWorkerScreen
                                                    ? 'tel://$phoneNumber'
                                                    : 'tel://${controller.phoneNumber}');
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                            const Divider(
                              color: kDarkBlue,
                              thickness: .9,
                              endIndent: 40,
                              indent: 40,
                            ),
                            (comeFromAllWorkerScreen &&
                                        controller.currentUserUid == id) ||
                                    (comeFromAllWorkerScreen == false &&
                                        controller.isTheSameUser)
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 25,
                                    ),
                                    child: CustomAuthButton(
                                      title: 'log_out'.tr,
                                      icon: Icons.exit_to_app_outlined,
                                      onTap: () => logOut(),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    heightFactor: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? 3
                        : 4.5,
                    child: ProfilePicture(
                      deviceSize: deviceSize,
                      imageURL: comeFromAllWorkerScreen
                          ? imageURl
                          : controller.imageUrl,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
