import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  // final String? id;
  final String messageContent;
  final String sendTo;
  final String sendFrom;
  final Timestamp timestamp;
  MessageModel({
    // this.id,
    required this.messageContent,
    required this.sendTo,
    required this.sendFrom,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'messageContent': messageContent,
      'sendTo': sendTo,
      'sendFrom': sendFrom,
      'timestamp': timestamp,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      // id: map['id'] ?? '',
      messageContent: map['messageContent'] ?? '',
      sendTo: map['sendTo'] ?? '',
      sendFrom: map['sendFrom'] ?? '',
      timestamp: map['timeStamp'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));
}
