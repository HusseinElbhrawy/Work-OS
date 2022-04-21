// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key? key,
    required this.deviceSize,
    this.imageURL,
  }) : super(key: key);

  final Size deviceSize;
  final String? imageURL;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: MediaQuery.of(context).orientation == Orientation.landscape
          ? deviceSize.height / 3.5
          : deviceSize.height / 14,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: MediaQuery.of(context).orientation == Orientation.landscape
            ? deviceSize.height / 4
            : deviceSize.height / 16,
        child: CircleAvatar(
          backgroundImage: imageURL == null
              ? const AssetImage('assets/images/man.png')
                  as ImageProvider<Object>
              : NetworkImage(imageURL.toString()),
          radius: MediaQuery.of(context).orientation == Orientation.landscape
              ? deviceSize.width / 9
              : deviceSize.height / 18,
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
