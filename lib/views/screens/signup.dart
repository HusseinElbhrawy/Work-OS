import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controller/signup_controller.dart';
import '/views/screens/login.dart';
import '/views/widgets/bg_image.dart';
import '/views/widgets/custom_auth_button.dart';
import '/views/widgets/custom_text_form_field.dart';
import '/views/widgets/filter_dialog.dart';
import '/views/widgets/image_picker_widget.dart';
import '/views/widgets/switch_between_auth_mode.dart';
import '/views/widgets/text_auth_title.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static final SignUpController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    Get.lazyPut(() => SignUpController(), fenix: true);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Form(
        key: controller.formKey,
        child: Center(
          child: Stack(
            children: [
              GetBuilder(
                builder: (SignUpController controller) => AnimatedBuilder(
                  animation: controller.controller,
                  builder: (BuildContext context, Widget? child) {
                    return BGImage(animation: controller.animation);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    SizedBox(height: deviceSize.height / 15),
                    const TextAuthTitle(title: 'Sign Up'),
                    SwitchBetweenAuthMode(
                      title1: "Already have an account?",
                      title2: '\tSign In',
                      onTap: () {
                        Get.off(() => LoginScreen());
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: GetBuilder(
                            builder: (SignUpController controller) {
                              return CustomTextFormFiled(
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
                                    return 'This name is too short';
                                  }
                                  return null;
                                },
                                labelText: 'Full Name',
                              );
                            },
                          ),
                        ),
                        const Expanded(child: ImagePickerWidget()),
                      ],
                    ),
                    GetBuilder(
                      builder: (SignUpController controller) {
                        return CustomTextFormFiled(
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
                              return 'This email is not valid';
                            }
                            return null;
                          },
                          labelText: 'Email',
                        );
                      },
                    ),
                    GetBuilder(
                      builder: (SignUpController controller) {
                        return CustomTextFormFiled(
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
                              return 'This password is short password , it should at least 7 letters';
                            }
                            return null;
                          },
                          labelText: 'Password',
                          suffixIcon: controller.isObscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          suffixIconFunction: () =>
                              controller.changePasswordSuffixIcon(),
                        );
                      },
                    ),
                    GetBuilder(
                      builder: (SignUpController controller) {
                        return CustomTextFormFiled(
                          onEditComplete: () {
                            buildFilterDialog(
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
                              return 'Not Valid';
                            }
                            return null;
                          },
                          labelText: 'phone Number',
                        );
                      },
                    ),
                    GetBuilder(
                      builder: (SignUpController controller) {
                        return CustomTextFormFiled(
                          onTap: () {
                            buildFilterDialog(
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
                              return 'Not Valid';
                            }
                            return null;
                          },
                          labelText: 'Company Position',
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                    Obx(
                      () {
                        return controller.isLoading.value
                            ? const LinearProgressIndicator()
                            : CustomAuthButton(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    controller.createAccount(
                                      email: controller.emailController.text,
                                      password:
                                          controller.passwordController.text,
                                    );
                                  }
                                },
                                title: 'Sign Up',
                                icon: Icons.person_add,
                              );
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
