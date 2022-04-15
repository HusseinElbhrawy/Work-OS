import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work_os/controller/signup_controller.dart';

import '/utils/const/const.dart';
import '/views/widgets/custom_row.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);
  static final SignUpController signUpController = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 80,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: signUpController.isFileImage.value == false
                    ? Image.asset(
                        'assets/images/man.png',
                      )
                    : Image.file(
                        signUpController.pickedImage!,
                        fit: BoxFit.cover,
                      ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 1,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }),
        PositionedDirectional(
          top: 0.0,
          end: 0.0,
          child: InkWell(
            onTap: () {
              Get.dialog(
                AlertDialog(
                  title: const Text(
                    'Please Choose an Option',
                    style: TextStyle(color: kDarkBlue),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomRow(
                        onTap: () {
                          signUpController.pickedImageMethod(
                              src: ImageSource.camera);
                        },
                        title: 'Camera',
                        icon: Icons.camera_outlined,
                      ),
                      CustomRow(
                        onTap: () {
                          signUpController.pickedImageMethod(
                              src: ImageSource.gallery);
                        },
                        title: 'Gallery',
                        icon: Icons.image_outlined,
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.pink,
                border: Border.all(width: 2, color: Colors.white),
                shape: BoxShape.circle,
              ),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.add_a_photo_outlined,
                  size: 10,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
