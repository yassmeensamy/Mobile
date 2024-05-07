import 'dart:convert';

class UserModel {
  String name;
  String? gender;
  String email;
  String studentId;
  int? level;
  String? password;
  String? ImageUrl;

  UserModel({
    required this.name,
    this.gender,
    required this.email,
    required this.studentId,
    this.level,
    this.password, 
    this.ImageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gender': gender,
      'email': email,
      'studentId': studentId,
      'level': level,
      'password': password,
    };
  }

  UserModel.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        gender = map['gender'],
        email = map['email'],
        studentId = map['studentId'],
        level = map['level'],
        password = map['password'];

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String jsonStr) {
    final Map<String, dynamic> map = json.decode(jsonStr);
    return UserModel(
      name: map['name'],
      gender: map['gender'],
      email: map['email'],
      studentId: map['studentId'],
      level: map['level'],
      password: map['password'],
    );
  }
}
