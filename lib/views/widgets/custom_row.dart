import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.purple),
            const VerticalDivider(),
            Text(
              title,
              style: const TextStyle(color: Colors.purple),
            ),
          ],
        ),
      ),
    );
  }
}
