import 'package:astra/models/user.dart';

class AuthResponse {
  final bool status;
  final String message;
  final String accessToken;
  final User user;

  AuthResponse({
    this.status,
    this.message,
    this.accessToken,
    this.user
  });

  factory AuthResponse.fromJson(Map json) {
    return AuthResponse(
      status: json["status"],
      message: json["message"],
      accessToken: json["access_token"],
      user: User.fromJson(json["user"]),
    );
  }
}

class AuthData {
  User user;
  String accessToken;
}
