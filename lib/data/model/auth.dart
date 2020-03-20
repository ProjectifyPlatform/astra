import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:astra/data/model/user.dart';

class Auth extends Equatable {
  final String accessToken;
  final User user;

  Auth({
    @required this.accessToken,
    @required this.user,
  });

  @override
  List<Object> get props => [
    accessToken,
    user
  ];

  // factory Auth.fromJson(Map<String, dynamic> json)
}

class SignUpData {
  final String email;
  final String username;
  final String name;
  final String password; 

  SignUpData({
    this.email,
    this.username,
    this.name,
    this.password,
  });

  Map<String, String> toJson() => {
    "email": email,
    "username": username,
    "name": name,
    "password": password,
  };
}
