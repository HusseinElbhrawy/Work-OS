import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/views/screens/fotget_password/forget_password.dart';

import '/controller/login_controller.dart';
import '../signup/signup.dart';
import '/views/widgets/bg_image.dart';
import '/views/widgets/custom_auth_button.dart';
import '/views/widgets/custom_text_form_field.dart';
import '/views/widgets/switch_between_auth_mode.dart';
import '/views/widgets/text_auth_title.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    Get.lazyPut(() => LoginController(), fenix: true);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: GetBuilder(
        builder: (LoginController controller) => Form(
          key: controller.formKey,
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
                    TextAuthTitle(title: 'login'.tr),
                    SwitchBetweenAuthMode(
                      title1: "don't_have_an_account".tr,
                      title2: 'sign_up'.tr,
                      onTap: () {
                        Get.off(() => const SignUpScreen());
                      },
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
                      onEditComplete: () {
                        FocusScope.of(context).unfocus();
                        if (controller.formKey.currentState!.validate()) {
                          controller.loginAccount(
                            email: controller.emailController.text,
                            password: controller.passwordController.text,
                          );
                        }
                      },
                      focusNode: controller.passwordFocusNode,
                      textInputAction: TextInputAction.done,
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
                      suffixIconFunction: () => controller.updateIcon(),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                        onPressed: () {
                          Get.to(() => const ForgetPassword());
                        },
                        child: Text(
                          'forget_password'.tr,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            decorationThickness: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Obx(
                      () {
                        if (controller.isLoading.value) {
                          return const LinearProgressIndicator();
                        } else {
                          return CustomAuthButton(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              if (controller.formKey.currentState!.validate()) {
                                controller.loginAccount(
                                  email: controller.emailController.text,
                                  password: controller.passwordController.text,
                                );
                              }
                            },
                            title: 'login'.tr,
                            icon: Icons.login,
                          );
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
