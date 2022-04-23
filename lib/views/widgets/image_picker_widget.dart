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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder(
            builder: (SignUpController controller) => Container(
              width: 80,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: controller.pickedImage == null
                    ? Image.asset('assets/images/man.png')
                    : Image.file(
                        controller.pickedImage!,
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
          ),
        ),
        PositionedDirectional(
          top: 0.0,
          end: 0.0,
          child: InkWell(
            onTap: () {
              Get.dialog(
                AlertDialog(
                  title: Text(
                    'Please_choose_an_image'.tr,
                    style: const TextStyle(color: kDarkBlue),
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
                        title: 'camera'.tr,
                        icon: Icons.camera_outlined,
                      ),
                      CustomRow(
                        onTap: () {
                          signUpController.pickedImageMethod(
                              src: ImageSource.gallery);
                        },
                        title: 'gallery'.tr,
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
