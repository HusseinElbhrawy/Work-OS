import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_os/controller/inner_chat_controller.dart';

class SendMessageWidget extends StatelessWidget {
  const SendMessageWidget({
    Key? key,
    required this.sendTo,
  }) : super(key: key);
  final String sendTo;
  static final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final InnerChatController controller = Get.put(InnerChatController());

    return Form(
      key: formKey,
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 120,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                log('Printed');
              },
              icon: const Icon(
                Icons.mic,
              ),
            ),
            GetBuilder(
              builder: (InnerChatController controller) {
                return Expanded(
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'You can\'t sent empty message ';
                      }
                      return null;
                    },
                    maxLines: null,
                    controller: controller.messageTextFormFiled,
                    onFieldSubmitted: (value) {
                      if (formKey.currentState!.validate()) {
                        controller.sendMessage(
                          message: controller.messageTextFormFiled.text.trim(),
                          sendTo: sendTo,
                        );
                      }
                    },
                    textInputAction: TextInputAction.send,
                    decoration: const InputDecoration(
                      hintText: 'Message...',
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CircleAvatar(
                child: IconButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      controller.sendMessage(
                        message: controller.messageTextFormFiled.text.trim(),
                        sendTo: sendTo,
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.send,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
