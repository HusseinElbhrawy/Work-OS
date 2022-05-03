import 'dart:convert';

class TaskModel {
  final String taskId;
  final String uploadBy;
  final String taskTitle;
  final String taskDescription;
  final String deadlineDate;
  final String taskCategory;
  final List<String> taskComments;
  final bool isDone;
  final String createdAt;
  TaskModel({
    required this.taskId,
    required this.uploadBy,
    required this.taskTitle,
    required this.taskDescription,
    required this.deadlineDate,
    required this.taskCategory,
    required this.taskComments,
    this.isDone = false,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'uploadBy': uploadBy,
      'taskTitle': taskTitle,
      'taskDescription': taskDescription,
      'deadlineDate': deadlineDate,
      'taskCategory': taskCategory,
      'taskComments': taskComments,
      'isDone': isDone,
      'createdAt': createdAt,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskId: map['taskId'] ?? '',
      uploadBy: map['uploadBy'] ?? '',
      taskTitle: map['taskTitle'] ?? '',
      taskDescription: map['taskDescription'] ?? '',
      deadlineDate: map['deadlineDate'] ?? '',
      taskCategory: map['taskCategory'] ?? '',
      taskComments: List<String>.from(map['taskComments']),
      isDone: map['isDone'] ?? false,
      createdAt: map['createdAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));
}
