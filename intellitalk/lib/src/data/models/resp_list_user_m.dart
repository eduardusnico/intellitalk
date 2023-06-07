// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intellitalk/src/data/models/user_m.dart' show User;

class ResponseListUser {
  bool status;
  int statusCode;
  String message;
  List<User> users;

  ResponseListUser({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.users,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'status_code': statusCode,
      'message': message,
      'data': users.map((x) => x.toMap()).toList(),
    };
  }

  factory ResponseListUser.fromMap(Map<String, dynamic> map) {
    return ResponseListUser(
      status: map['status'] as bool,
      statusCode: map['status_code'] as int,
      message: map['message'] as String,
      users: List<User>.from(
        (map['data'] as List<dynamic>).map<User>(
          (x) => User.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseListUser.fromJson(String source) =>
      ResponseListUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
