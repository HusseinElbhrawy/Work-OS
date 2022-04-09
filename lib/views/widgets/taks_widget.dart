import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        onTap: () {},
        onLongPress: () {},
        leading: Container(
          padding: const EdgeInsetsDirectional.only(end: 10),
          decoration: const BoxDecoration(
            border: BorderDirectional(
              end: BorderSide(
                width: 2,
                color: Colors.red,
              ),
            ),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.asset(
              'assets/images/check.png',
              color: Colors.green.shade200,
            ),
          ),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.keyboard_arrow_right),
        ),
        title: Text(
          'Title',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.linear_scale,
              color: Colors.pink.shade800,
            ),
            Text(
              'SubTitle / Description',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
