import 'dart:convert';
import 'package:astra/data/model/user.dart';
import 'package:astra/data/model/auth.dart';
import 'package:http/http.dart' as http;

abstract class AuthRepository {
  Future<Auth> login({
    String email,
    String password,
  });

  Future<Auth> signUp(SignUpData data);

  Future<bool> isAuthenticated();
  Future<void> persistAuth(Auth auth);
  Future<void> deAuthenticate();
}

class APIAuthRepository implements AuthRepository {

  @override
  Future<bool> persistAuth(Auth auth) async {
    // IMPLEMENT: Saving auth details.
    await Future.delayed(Duration(seconds: 1));
    return true;
  }

  @override
  Future<bool> isAuthenticated() async {
    // Simulate network delay.
    await Future.delayed(Duration(seconds: 1));
    return false;
    // IMPLEMENT: Getting stored token and checking if user is authenticated or not.
  }

  @override
  Future<void> deAuthenticate() async {
    // Simulate delay
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Future<Auth> login({String email, String password}) async {
    final String url = 'http://192.168.1.120:5000/auth/login';

    Map<String, String> loginData = {
      "email": email,
      "password": password,
    };

    final resp = await http.post(url,
      body: json.encode(loginData),
      headers: {"Content-Type": "application/json"},
    );

    // Handle errors.
    if (resp.statusCode == 400) {
      // Get the first error.
      Map<String, dynamic> errors = json.decode(resp.body)['errors'];
      String key = errors.keys.elementAt(0);

      throw InvalidLogin(errors[key][0].toString());
    }

    Map<String, dynamic> data = json.decode(resp.body);
    String accessToken = data['access_token'];
    User user = data['user'];

    // Use error handling when calling this Future.
    return Auth(accessToken: accessToken, user: user);
  }

  @override
  Future<Auth> signUp(SignUpData signUpData) async {
    final String url = 'http://192.168.1.120:5000/auth/register';

    final resp = await http.post(url,
      body: signUpData.toJson(),
      headers: {
        "Content-Type": "application/json",
      }
    );

    Map<String, dynamic> data = json.decode(resp.body);
    String accessToken = data['access_token'];
    User user = data['user'];   

    // Use error handling when calling this Future.
    return Auth(accessToken: accessToken, user: user);
  }
}

class InvalidLogin implements Exception {
  final String errorMsg;
  const InvalidLogin(this.errorMsg);

  String toString() => this.errorMsg;
}
