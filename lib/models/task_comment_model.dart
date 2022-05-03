import 'dart:convert';

class TaskCommentModel {
  final String userId;
  final String commentId;
  final String commentBody;
  final String userName;
  final String userImage;
  final String timestamp;

  TaskCommentModel({
    required this.userImage,
    required this.timestamp,
    required this.commentBody,
    required this.commentId,
    required this.userId,
    required this.userName,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'commentId': commentId,
      'commentBody': commentBody,
      'userName': userName,
      'userImage': userImage,
      'timestamp': timestamp,
    };
  }

  factory TaskCommentModel.fromMap(Map<String, dynamic> map) {
    return TaskCommentModel(
      userId: map['userId'] ?? '',
      commentId: map['commentId'] ?? '',
      commentBody: map['commentBody'] ?? '',
      userName: map['userName'] ?? '',
      userImage: map['userImage'] ?? '',
      timestamp: map['timestamp'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskCommentModel.fromJson(String source) =>
      TaskCommentModel.fromMap(json.decode(source));
}
