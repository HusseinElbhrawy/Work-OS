import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class MessageTextWidget extends StatelessWidget {
  const MessageTextWidget({
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
    return Column(
      children: [
        BubbleSpecialOne(
          color: isTheSameUser ? Colors.red : Colors.blue,
          isSender: !isTheSameUser,
          textStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
          sent: true,
          text: message,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Align(
              alignment: isTheSameUser
                  ? AlignmentDirectional.bottomStart
                  : AlignmentDirectional.bottomEnd,
              child:
                  Text(intl.DateFormat('hh:mm a').format(timestamp.toDate())),
            ),
          ),
        )
      ],
    );
  }
}
