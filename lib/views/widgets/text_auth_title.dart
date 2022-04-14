import 'package:flutter/material.dart';

class TextAuthTitle extends StatelessWidget {
  const TextAuthTitle({
    Key? key,
    required this.title,
    this.color,
  }) : super(key: key);
  final String title;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: color ?? Colors.white,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
