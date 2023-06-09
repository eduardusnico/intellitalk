// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intellitalk/src/data/models/messages_m.dart';

class ResponseListMessages {
  bool status;
  int statusCode;
  String message;
  List<Messages> data;
  ResponseListMessages({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'status_code': statusCode,
      'message': message,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory ResponseListMessages.fromMap(Map<String, dynamic> map) {
    return ResponseListMessages(
      status: map['status'] as bool,
      statusCode: map['status_code'] as int,
      message: map['message'] as String,
      data: List<Messages>.from(
        (map['data'] as List<dynamic>).map<Messages>(
          (x) => Messages.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseListMessages.fromJson(String source) =>
      ResponseListMessages.fromMap(json.decode(source) as Map<String, dynamic>);
}
