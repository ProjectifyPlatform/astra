import 'dart:convert';
import 'package:astra/data/model/user.dart';
import 'package:astra/data/model/auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
  Future<void> persistAuth(Auth auth) async {
    // Get shared preferences.
    final prefs = await SharedPreferences.getInstance();

    // Set values
    prefs.setString('accessToken', auth.accessToken);
    prefs.setString('user', json.encode(auth.user.toJson()));
  }

  @override
  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('accessToken') ?? false;
    final user = prefs.getString('user') ?? false;

    if (token && user) {
      return true;
    }

    return false;
  }

  @override
  Future<void> deAuthenticate() async {
    // Simulate delay
    final prefs = await SharedPreferences.getInstance();

    prefs.remove('accessToken');
    prefs.remove('user');
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

    } else if (resp.statusCode != 400 && resp.statusCode != 200) {
      String errorMsg = json.decode(resp.body)['message'];
      throw InvalidLogin(errorMsg);
    }

    Map<String, dynamic> data = json.decode(resp.body);

    String accessToken = data['access_token'];
    User user = User.fromJson(data['user']);

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
