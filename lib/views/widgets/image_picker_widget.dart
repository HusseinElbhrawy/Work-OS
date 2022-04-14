import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '/utils/const/const.dart';
import '/views/widgets/custom_row.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  static File? _pickedImage;
  static final ImagePicker _picker = ImagePicker();

  void pickedImage({required ImageSource src}) async {
    _picker
        .pickImage(
      source: src,
      maxWidth: 1080,
      maxHeight: 1080,
    )
        .then((value) async {
      if (value != null) {
        _cropImage(value.path);
        Get.back();
      } else {
        Get.back();
        throw 'Please Select an Image';
      }
    }).catchError(
      (error) {
        log("User didn't picked image yet");
        Get.snackbar(
          'Warning',
          error,
          colorText: kDarkBlue,
          backgroundColor: Colors.white,
        );
      },
    );
  }

  void _cropImage(path) async {
    ImageCropper()
        .cropImage(
      sourcePath: path,
    )
        .then((value) {
      if (value != null) {
        setState(() {
          _pickedImage = value;
        });
      } else {
        Get.back();
        throw 'Please Select an Image';
      }
    }).catchError((error) {
      Get.snackbar(
        'Warning',
        error,
        colorText: kDarkBlue,
        backgroundColor: Colors.white,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 80,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _pickedImage == null
                  ? Image.asset(
                      'assets/images/man.png',
                    )
                  : Image.file(
                      _pickedImage!,
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
                          pickedImage(src: ImageSource.camera);
                        },
                        title: 'Camera',
                        icon: Icons.camera_outlined,
                      ),
                      CustomRow(
                        onTap: () {
                          pickedImage(src: ImageSource.gallery);
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
