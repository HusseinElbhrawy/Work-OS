import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String taskId;
  final String uploadBy;
  final String taskTitle;
  final String taskDescription;
  final Timestamp deadlineDateTimeStamp;
  final String taskCategory;
  final String deadlineDate;
  final List<String> taskComments;
  final bool isDone;
  final Timestamp createdAt;
  TaskModel({
    required this.taskId,
    required this.uploadBy,
    required this.taskTitle,
    required this.taskDescription,
    required this.deadlineDateTimeStamp,
    required this.deadlineDate,
    required this.taskCategory,
    required this.taskComments,
    this.isDone = false,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'TaskID': taskId,
      'UploadedBy': uploadBy,
      'TaskTitle': taskTitle,
      'TaskDescription': taskDescription,
      'DeadlineDateTimeStamp': deadlineDateTimeStamp,
      'DeadlineDate': deadlineDate,
      'TaskCategory': taskCategory,
      'TaskComments': taskComments,
      'IsDone': isDone,
      'CreatedAt': createdAt,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskId: map['TaskID'] ?? '',
      uploadBy: map['UploadedBy'] ?? '',
      taskTitle: map['TaskTitle'] ?? '',
      taskDescription: map['TaskDescription'] ?? '',
      deadlineDateTimeStamp: map['DeadlineDateTimeStamp'] ?? '',
      deadlineDate: map['DeadlineDate'] ?? '',
      taskCategory: map['TaskCategory'] ?? '',
      taskComments: List<String>.from(map['TaskComments']),
      isDone: map['IsDone'] ?? false,
      createdAt: map['CreatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));
}
