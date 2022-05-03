import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageItemWidget extends StatelessWidget {
  const MessageItemWidget({
    Key? key,
    required this.message,
    required this.timestamp,
  }) : super(key: key);
  final String message;
  final Timestamp timestamp;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
        color: Colors.red,
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }
}
