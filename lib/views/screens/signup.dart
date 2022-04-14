import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/views/widgets/image_picker_widget.dart';

import '/views/screens/login.dart';
import '/views/widgets/bg_image.dart';
import '/views/widgets/custom_auth_button.dart';
import '/views/widgets/custom_text_form_field.dart';
import '/views/widgets/filter_dialog.dart';
import '/views/widgets/switch_between_auth_mode.dart';
import '/views/widgets/text_auth_title.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController controller;
  late Animation<double> animation;
  final _fullNameFocusNode = FocusNode(),
      _emailFocusNode = FocusNode(),
      _companyPosition = FocusNode(),
      _phoneNumber = FocusNode();

  final _passwordFocusNode = FocusNode();

  final emailController = TextEditingController(),
      passwordController = TextEditingController(),
      fullNameController = TextEditingController(),
      companyPositionController = TextEditingController(),
      phoneController = TextEditingController();

  final List<String> jobList = [
    'Manager',
    'Team Leader',
    'Designer',
    'Web Designer',
    'Full Stack Developer',
    'Mobile Developer',
    'Marketing',
    'Digital Marketing',
  ];

  bool isObscureText = true;
  IconData iconData = Icons.visibility;
  void changePasswordSuffixIcon() {
    isObscureText = !isObscureText;
    setState(() {});
  }

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 20))
          ..repeat();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Form(
        key: _formKey,
        child: Center(
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, Widget? child) {
                  return BGImage(animation: animation);
                },
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
                        Get.off(() => const LoginScreen());
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: CustomTextFormFiled(
                            focusNode: _fullNameFocusNode,
                            textInputAction: TextInputAction.next,
                            onEditComplete: () {
                              _fullNameFocusNode.nextFocus();
                            },
                            obscureText: false,
                            keyboardType: TextInputType.name,
                            controller: fullNameController,
                            validator: (value) {
                              if (value!.length < 2 || value.isEmpty) {
                                return 'This name is too short';
                              }
                              return null;
                            },
                            labelText: 'Full Name',
                          ),
                        ),
                        Expanded(
                          child: ImagePickerWidget(),
                        ),
                      ],
                    ),
                    CustomTextFormFiled(
                      focusNode: _emailFocusNode,
                      textInputAction: TextInputAction.next,
                      onEditComplete: () {
                        _emailFocusNode.nextFocus();
                      },
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (value) {
                        if (!value!.contains('@') ||
                            value.isEmpty ||
                            !value.contains('.')) {
                          return 'This email is not valid';
                        }
                        return null;
                      },
                      labelText: 'Email',
                    ),
                    CustomTextFormFiled(
                      focusNode: _passwordFocusNode,
                      textInputAction: TextInputAction.next,
                      onEditComplete: () {
                        FocusScope.of(context).requestFocus(_phoneNumber);
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isObscureText,
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'This password is short password , it should at least 7 letters';
                        }
                        return null;
                      },
                      labelText: 'Password',
                      suffixIcon: isObscureText
                          ? Icons.visibility
                          : Icons.visibility_off,
                      suffixIconFunction: () => changePasswordSuffixIcon(),
                    ),
                    CustomTextFormFiled(
                      textInputAction: TextInputAction.next,
                      focusNode: _phoneNumber,
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return 'Not Valid';
                        }
                        return null;
                      },
                      labelText: 'phone Number',
                    ),
                    CustomTextFormFiled(
                      onTap: () async {
                        buildFilterDialog(
                          deviceSize,
                          list: jobList,
                          companyPositionController: companyPositionController,
                        );
                      },
                      enable: false,
                      textInputAction: TextInputAction.done,
                      focusNode: _companyPosition,
                      obscureText: false,
                      onEditComplete: () {
                        print('Hello World ');
                      },
                      keyboardType: TextInputType.text,
                      controller: companyPositionController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 2) {
                          return 'Not Valid';
                        }
                        return null;
                      },
                      labelText: 'Company Position',
                    ),
                    const SizedBox(height: 40),
                    CustomAuthButton(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {}
                      },
                      title: 'Sign Up',
                      icon: Icons.person_add,
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

  @override
  void dispose() {
    print('Disposed Start');
    controller.dispose();
    companyPositionController.dispose();
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    super.dispose();
    print('Disposed End');
  }
}
