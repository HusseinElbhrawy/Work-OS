import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/views/screens/signup.dart';
import 'package:work_os/views/widgets/bg_image.dart';
import 'package:work_os/views/widgets/custom_auth_button.dart';
import 'package:work_os/views/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool isObscureText = true;
  IconData iconData = Icons.visibility;
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(),
      _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode(), _passwordFocusNode = FocusNode();

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 20))
          ..repeat();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    _emailController.clear();
    _passwordController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Form(
        key: formKey,
        child: Center(
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  return BGImage(animation: _animation);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    SizedBox(height: deviceSize.height / 15),
                    Text(
                      'Login',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Don't have an account?",
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.off(() => const SignUpScreen());
                          },
                          child: Text(
                            '\tSIGN UP',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Colors.blue,
                                    ),
                          ),
                        )
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
                      controller: _passwordController,
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
                      onEditComplete: () {
                        print('Hello World');
                      },
                      focusNode: _passwordFocusNode,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isObscureText,
                      controller: _emailController,
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
                      suffixIconFunction: () {
                        setState(() {
                          isObscureText = !isObscureText;
                          print(isObscureText);
                        });
                      },
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forget Password?',
                          style: TextStyle(
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
                    CustomAuthButton(
                      onTap: () {
                        // Get.off(() => HomeScreen());
                        FocusScope.of(context).unfocus();
                      },
                      title: 'Login',
                      icon: Icons.login,
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
    _controller.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
