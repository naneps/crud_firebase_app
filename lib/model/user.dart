class User {
  String? id;
  final String? name;
  final int? age;
  final DateTime? birthday;
  User({this.name, this.age, this.birthday});

  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
        'birrthday': birthday,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        name: json['name'] as String,
        age: json['age'] as int,
        birthday: json['birthday'] as DateTime,
      );
}
