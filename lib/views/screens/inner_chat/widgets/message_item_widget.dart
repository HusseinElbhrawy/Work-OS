import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageItemWidget extends StatelessWidget {
  const MessageItemWidget({
    Key? key,
    required this.message,
    required this.timestamp,
    required this.isTheSameUser,
  }) : super(key: key);
  final String message;
  final Timestamp timestamp;
  final bool isTheSameUser;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: isTheSameUser
          ? AlignmentDirectional.topEnd
          : AlignmentDirectional.topStart,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(16),
        width: size.width / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              overflow: TextOverflow.fade,
              maxLines: null,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Text(DateFormat('K:mm').format(timestamp.toDate())),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: isTheSameUser ? Colors.red : Colors.blue,
          borderRadius: isTheSameUser
              ? const BorderRadiusDirectional.only(
                  topEnd: Radius.circular(0),
                  bottomEnd: Radius.circular(18),
                  bottomStart: Radius.circular(18),
                  topStart: Radius.circular(18),
                )
              : const BorderRadiusDirectional.only(
                  topEnd: Radius.circular(18),
                  bottomEnd: Radius.circular(18),
                  bottomStart: Radius.circular(18),
                  topStart: Radius.circular(0),
                ),
        ),
      ),
    );
  }
}
