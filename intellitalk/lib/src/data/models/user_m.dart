import 'dart:convert';

class UserResponse {
  bool status;
  int statusCode;
  String message;
  User user;

  UserResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'statusCode': statusCode,
      'message': message,
      'user': user.toMap(),
    };
  }

  factory UserResponse.fromMap(Map<String, dynamic> map) {
    return UserResponse(
      status: map['status'] as bool,
      statusCode: map['status_code'] as int,
      message: map['message'] as String,
      user: User.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponse.fromJson(String source) =>
      UserResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String id;
  String name;
  String email;
  String division;
  String position;
  String skill;
  int quantity;
  String link;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.division,
    required this.position,
    required this.skill,
    required this.quantity,
    required this.link,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'division': division,
      'position': position,
      'skill': skill,
      'quantity': quantity,
      'link': link,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      division: map['division'] as String,
      position: map['position'] as String,
      skill: map['skill'] as String,
      quantity: map['quantity'] == null ? 2 : map['quantity'] as int,
      link: map['link'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
