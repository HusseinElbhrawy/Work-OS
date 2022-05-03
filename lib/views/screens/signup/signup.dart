import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controller/signup_controller.dart';
import '../login/login.dart';
import '/views/widgets/bg_image.dart';
import '/views/widgets/custom_auth_button.dart';
import '/views/widgets/custom_text_form_field.dart';
import '../../widgets/custom_dialog.dart';
import '/views/widgets/image_picker_widget.dart';
import '/views/widgets/switch_between_auth_mode.dart';
import '/views/widgets/text_auth_title.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    // Get.lazyPut(() => SignUpController(), fenix: true);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: GetBuilder(
        init: SignUpController(),
        builder: (SignUpController controller) {
          return Form(
            key: controller.formKey,
            child: Center(
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: controller.controller,
                    builder: (BuildContext context, Widget? child) {
                      return BGImage(animation: controller.animation);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      children: [
                        SizedBox(height: deviceSize.height / 15),
                        TextAuthTitle(title: 'sign_up'.tr),
                        SwitchBetweenAuthMode(
                          title1: 'already_have_an_account'.tr,
                          title2: 'login'.tr,
                          onTap: () {
                            Get.off(() => const LoginScreen());
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: CustomTextFormFiled(
                                focusNode: controller.fullNameFocusNode,
                                textInputAction: TextInputAction.next,
                                onEditComplete: () {
                                  controller.fullNameFocusNode.nextFocus();
                                },
                                obscureText: false,
                                keyboardType: TextInputType.name,
                                controller: controller.fullNameController,
                                validator: (value) {
                                  if (value!.length < 2 || value.isEmpty) {
                                    return 'name_message_wrong'.tr;
                                  }
                                  return null;
                                },
                                labelText: 'full_name'.tr,
                              ),
                            ),
                            const Expanded(child: ImagePickerWidget()),
                          ],
                        ),
                        CustomTextFormFiled(
                          focusNode: controller.emailFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditComplete: () {
                            controller.emailFocusNode.nextFocus();
                          },
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          controller: controller.emailController,
                          validator: (value) {
                            if (!value!.contains('@') ||
                                value.isEmpty ||
                                !value.contains('.')) {
                              return 'this_email_is_not_valid'.tr;
                            }
                            return null;
                          },
                          labelText: 'email'.tr,
                        ),
                        CustomTextFormFiled(
                          focusNode: controller.passwordFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditComplete: () {
                            FocusScope.of(context)
                                .requestFocus(controller.phoneNumber);
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: controller.isObscureText,
                          controller: controller.passwordController,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return 'password_message_wrong'.tr;
                            }
                            return null;
                          },
                          labelText: 'password'.tr,
                          suffixIcon: controller.isObscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          suffixIconFunction: () =>
                              controller.changePasswordSuffixIcon(),
                        ),
                        CustomTextFormFiled(
                          onEditComplete: () {
                            customDialog(
                              deviceSize,
                              list: controller.jobList,
                              companyPositionController:
                                  controller.companyPositionController,
                            );
                          },
                          textInputAction: TextInputAction.next,
                          focusNode: controller.phoneNumber,
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                          controller: controller.phoneController,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return 'not_valid'.tr;
                            }
                            return null;
                          },
                          labelText: 'phone_number'.tr,
                        ),
                        CustomTextFormFiled(
                          onTap: () {
                            customDialog(
                              deviceSize,
                              list: controller.jobList,
                              companyPositionController:
                                  controller.companyPositionController,
                            );
                          },
                          enable: false,
                          textInputAction: TextInputAction.done,
                          focusNode: controller.companyPosition,
                          obscureText: false,
                          onEditComplete: () {
                            FocusScope.of(context).unfocus();
                            if (controller.formKey.currentState!.validate()) {
                              controller.createAccount(
                                email: controller.emailController.text,
                                password: controller.passwordController.text,
                              );
                            }
                          },
                          keyboardType: TextInputType.text,
                          controller: controller.companyPositionController,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 2) {
                              return 'not_valid'.tr;
                            }
                            return null;
                          },
                          labelText: 'company_position'.tr,
                        ),
                        const SizedBox(height: 40),
                        GetX(
                          builder: (SignUpController controller) {
                            return Center(
                              child: controller.isLoading.value
                                  ? const LinearProgressIndicator()
                                  : CustomAuthButton(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        if (controller.formKey.currentState!
                                            .validate()) {
                                          controller.createAccount(
                                            email:
                                                controller.emailController.text,
                                            password: controller
                                                .passwordController.text,
                                          );
                                        }
                                      },
                                      title: 'sign_up'.tr,
                                      icon: Icons.person_add,
                                    ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
