import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isResetPassword = false,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Function onTap;
  final bool isResetPassword;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: isResetPassword ? 10 : 13),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isResetPassword ? 5 : 13),
        side: BorderSide.none,
      ),
      color: Colors.pink.shade700,
      onPressed: () => onTap(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const VerticalDivider(color: Colors.transparent),
          Icon(
            icon,
            color: isResetPassword ? Colors.pink.shade700 : Colors.white,
          ),
        ],
      ),
    );
  }
}
