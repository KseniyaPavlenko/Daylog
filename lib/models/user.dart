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
      : id = json['id'] as String,
        login = json['login'] as String,
        password = json['password'] as String;
  // User.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       login = json['login'],
  //       password = json['password'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'login': login,
        'password': password,
      };
  Map<String, dynamic> toJsonWithoutPassword() => <String, dynamic>{
        'id': id,
        'login': login,
      };

  @override
  List<Object?> get props {
    return [id, login, password];
  }
}
