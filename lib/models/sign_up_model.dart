import 'dart:convert';

class SignUpModel {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  final String phoneNumber;
  final String positionInCompany;
  final String createdAt;
  SignUpModel({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.phoneNumber,
    required this.positionInCompany,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'positionInCompany': positionInCompany,
      'createdAt': createdAt,
    };
  }

  factory SignUpModel.fromMap(Map<String, dynamic> map) {
    return SignUpModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      positionInCompany: map['positionInCompany'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpModel.fromJson(String source) =>
      SignUpModel.fromMap(json.decode(source));
}
