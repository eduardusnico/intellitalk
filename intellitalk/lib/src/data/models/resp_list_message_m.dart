// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intellitalk/src/data/models/messages_m.dart';

class ResponseListMessage {
  bool status;
  int statusCode;
  String message;
  Messages listMessage;
  ResponseListMessage({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.listMessage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'status_code': statusCode,
      'message': message,
      'data': listMessage.toMap(),
    };
  }

  factory ResponseListMessage.fromMap(Map<String, dynamic> map) {
    return ResponseListMessage(
      status: map['status'] as bool,
      statusCode: map['status_code'] as int,
      message: map['message'] as String,
      listMessage: Messages.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseListMessage.fromJson(String source) =>
      ResponseListMessage.fromMap(json.decode(source) as Map<String, dynamic>);
}
