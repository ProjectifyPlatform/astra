part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthUninitialized extends AuthState {
  @override

  List<Object> get props => [];
}

class Authenticated extends AuthState {

  @override
  List<Object> get props => [];
}

// Indicates that an auth process is going on (Logging in/ Signing up/ Logging out).
class Authenticating extends AuthState {
  @override

  List<Object> get props => [];
}

class Unauthenticated extends AuthState {
  @override

  List<Object> get props => [];
}
