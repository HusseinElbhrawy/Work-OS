import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key? key,
    required this.deviceSize,
  }) : super(key: key);

  final Size deviceSize;

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
          backgroundImage: const AssetImage('assets/images/man.png'),
          radius: MediaQuery.of(context).orientation == Orientation.landscape
              ? deviceSize.width / 9
              : deviceSize.height / 18,
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
