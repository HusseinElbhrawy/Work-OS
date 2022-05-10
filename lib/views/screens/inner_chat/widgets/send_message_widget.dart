import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            GetBuilder(
              builder: (InnerChatController controller) => Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onLongPressStart: (details) async {
                    HapticFeedback.heavyImpact();
                    HapticFeedback.vibrate();
                    HapticFeedback.vibrate();
                    log('started');
                    controller.record();
                  },
                  onLongPressEnd: (fetails) async {
                    log('canceld');
                    await controller.stop();
                    controller.sendVoiceNote(sendTo: sendTo);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: controller.isVoiceUploded
                          ? const Icon(
                              Icons.upload,
                              color: Colors.blue,
                            )
                          : Icon(
                              controller.isRecordering ? Icons.stop : Icons.mic,
                              color: controller.isRecordering
                                  ? Colors.red
                                  : Colors.white,
                            ),
                    ),
                  ),
                ),
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
                        FocusScope.of(context).unfocus();
                      }
                    },
                    textInputAction: TextInputAction.send,
                    decoration: InputDecoration(
                      hintText: 'message'.tr,
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
                      FocusScope.of(context).unfocus();
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
