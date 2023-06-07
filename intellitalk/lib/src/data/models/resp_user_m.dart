import 'dart:convert';

import 'package:intellitalk/src/data/models/user_m.dart';

class ResponseUser {
  bool status;
  int statusCode;
  String message;
  User user;

  ResponseUser({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'status_code': statusCode,
      'message': message,
      'user': user.toMap(),
    };
  }

  factory ResponseUser.fromMap(Map<String, dynamic> map) {
    return ResponseUser(
      status: map['status'] as bool,
      statusCode: map['status_code'] as int,
      message: map['message'] as String,
      user: User.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseUser.fromJson(String source) =>
      ResponseUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
