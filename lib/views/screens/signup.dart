import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/views/screens/login.dart';
import 'package:work_os/views/widgets/bg_image.dart';
import 'package:work_os/views/widgets/custom_auth_button.dart';
import 'package:work_os/views/widgets/custom_text_form_field.dart';

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
      _companyPosition = FocusNode();

  final _passwordFocusNode = FocusNode();

  final emailController = TextEditingController(),
      passwordController = TextEditingController(),
      fullNameController = TextEditingController(),
      companyPositionController = TextEditingController();

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
                    Text(
                      'Sign Up',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Already have an account?",
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.off(() => LoginScreen());
                          },
                          child: Text(
                            '\tSign In',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Colors.blue,
                                    ),
                          ),
                        )
                      ],
                    ),
                    CustomTextFormFiled(
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
                        FocusScope.of(context).requestFocus(_companyPosition);
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
