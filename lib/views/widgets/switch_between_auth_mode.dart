import 'package:flutter/material.dart';

class SwitchBetweenAuthMode extends StatelessWidget {
  const SwitchBetweenAuthMode({
    Key? key,
    required this.onTap,
    required this.title1,
    required this.title2,
  }) : super(key: key);
  final String title1, title2;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title1,
          style: Theme.of(context).textTheme.headline6!.copyWith(
            color: Colors.white,
          ),
        ),
        TextButton(
          onPressed: () => onTap(),
          child: Text(
            title2,
            style: Theme.of(context).textTheme.headline6!.copyWith(
              color: Colors.blue,
            ),
          ),
        )
      ],
    );
  }
}
