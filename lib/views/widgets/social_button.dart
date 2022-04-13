import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    Key? key,
    required this.iconData,
    required this.onTap,
    required this.iconColor,
  }) : super(key: key);
  final IconData iconData;
  final Function onTap;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: iconColor,
      radius: 25,
      child: CircleAvatar(
        radius: 23,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: Icon(
            iconData,
            color: iconColor,
          ),
          onPressed: () => onTap(),
        ),
      ),
    );
  }
}
