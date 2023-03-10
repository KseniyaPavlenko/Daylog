import 'package:equatable/equatable.dart';

class User with EquatableMixin {
  final String? id;
  final String login;
  final String? password;

  const User({
    this.id,
    required this.login,
    this.password,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        login = json['login'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'login': login,
        'password': password,
      };
  Map<String, dynamic> toJsonWithoutPassword() => {
        'id': id,
        'login': login,
      };

  @override
  List<Object?> get props {
    return [id, login, password];
  }
}
