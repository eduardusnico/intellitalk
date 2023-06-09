import 'dart:convert';

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
  int status;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.division,
    required this.position,
    required this.skill,
    required this.quantity,
    required this.link,
    required this.status,
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
      'status': status,
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
        link: map['link'] == null ? '' : map['link'] as String,
        status: map['status'] == null ? 0 : map['status'] as int);
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
