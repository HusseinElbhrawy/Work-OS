import 'package:flutter/material.dart';
import 'package:work_os/utils/const/const.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.title,
    required this.onTap,
    required this.icon,
  }) : super(key: key);
  final Function onTap;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(),
      leading: Icon(icon, color: kDarkBlue),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: kDarkBlue,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
