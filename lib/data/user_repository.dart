import 'dart:convert';
import 'package:astra/data/model/user.dart';
import 'package:http/http.dart' as http;

abstract class AbstractUserRepository {
  // IMPLEMENT: Fetch user is getting the current user's data via AccessToken.
  // Future<User> fetchUser(String email);

  Future<User> fetchByUsername(String username);
}

class UserRepository implements AbstractUserRepository {
  @override
  Future<User> fetchByUsername(String username) async {
    final String url = 'http://192.168.1.120:5000/user/$username';

    final resp = await http.get(url, headers: {
      "Content-Type": "application/json"
    });

    // Implement throwing exceptions.
    return User.fromJson(json.decode(resp.body)["user"]);
  }
}