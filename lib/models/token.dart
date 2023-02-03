import 'package:equatable/equatable.dart';

class Token with EquatableMixin {
  final String token;

  Token({
    required this.token,
  });

  Token.fromJson(Map<String, dynamic> json) : token = json['token'];

  Map<String, dynamic> toJson() => {
        'token': token,
      };

  @override
  List<Object?> get props {
    return [token];
  }
}
