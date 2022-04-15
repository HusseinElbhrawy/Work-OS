import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/controller/forget_controller.dart';
import '/views/widgets/bg_image.dart';
import '/views/widgets/custom_auth_button.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: GetBuilder(
        init: ForgetController(),
        builder: (ForgetController controller) {
          return Stack(
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
                    Text(
                      'Forget Password',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const Divider(color: Colors.transparent),
                    Text(
                      'Email address',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const Divider(color: Colors.transparent),
                    TextFormField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const Divider(color: Colors.transparent),
                    CustomAuthButton(
                      title: 'Reset Password',
                      icon: Icons.add,
                      onTap: () {},
                      isResetPassword: true,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
