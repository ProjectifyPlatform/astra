import 'dart:convert';
import 'package:astra/models/auth.dart';
import 'package:http/http.dart' as http;

class InvalidLogin implements Exception {
  final String msg;
  const InvalidLogin(this.msg);

  String toString() => this.msg;
}

class AuthService {
  // Login
  Future login(String email, String password) async {
      // String url = "http://192.168.1.120:5000/auth/login";
      String url = "http://konishi-zimmerman.herokuapp.com/auth/login";

      Map<String, String> loginData = {
        "email": email,
        "password": password,
      };

      final resp = await http.post(url,
        body: json.encode(loginData),
        headers: {"Content-Type": "application/json"},
      );

      if (resp.statusCode == 200) {
        return AuthResponse.fromJson(json.decode(resp.body));

      } else if (resp.statusCode == 403 || resp.statusCode == 404) {
        String errorMsg = json.decode(resp.body)["message"];
        throw InvalidLogin(errorMsg);
      }
  }

  // Register
  Future register(registerData) async {
    // Implement register logic
  }
}