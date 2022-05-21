import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  final String? name;
  final int? age;
  final DateTime? birthday;
  User({this.id, this.name, this.age, this.birthday});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'birthday': birthday,
      };

  static User fromJson(Map<String, dynamic> json) => User(
      id: json['id'] ?? "default",
      name: json['name'] ?? "default",
      age: json['age'],
      birthday: (json['birthday'] as Timestamp).toDate());
}
