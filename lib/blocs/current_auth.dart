import 'package:astra/models/user.dart';
import 'package:flutter/material.dart';

class CurrentAuthBloc extends ChangeNotifier {
  User _currentUser;
  User get currentUser => _currentUser;

  String _accessToken;
  String get accessToken => _accessToken;

  set currentUser(User user) {
    _currentUser = user;

    notifyListeners();
  }

  set accessToken(String token) {
    _accessToken = token;

    notifyListeners();
  }
}