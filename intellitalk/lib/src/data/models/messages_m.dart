// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intellitalk/src/data/models/message_m.dart';

class Messages {
  String id;
  String userId;
  List<Message> messages;
  Messages({
    required this.id,
    required this.userId,
    required this.messages,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'messages': messages.map((x) => x.toMap()).toList(),
    };
  }

  factory Messages.fromMap(Map<String, dynamic> map) {
    return Messages(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      messages: List<Message>.from(
        (map['messages'] as List<dynamic>).map<Message>(
          (x) => Message.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Messages.fromJson(String source) =>
      Messages.fromMap(json.decode(source) as Map<String, dynamic>);
}
