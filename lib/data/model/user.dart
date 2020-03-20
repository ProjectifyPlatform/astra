import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String email;
  final String name;
  final String username;
  final String joinedDate;
  final int roleId;

  User({
    this.email,
    this.name,
    this.username,
    this.joinedDate,
    this.roleId,
  });

  @override
  List<Object> get props => [
    email,
    name,
    username,
    joinedDate,
    roleId,
  ];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      name: json['name'],
      username: json['username'],
      joinedDate: json['joined_date'],
      roleId: json['role_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    "email": email,
    "name": name,
    "username": username,
    "joinedDate": joinedDate,
    "roleId": roleId,
  };
}