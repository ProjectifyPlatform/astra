part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AppStarted extends AuthEvent {
  const AppStarted();

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthEvent {
  final Auth auth;

  const LoggedIn({
    @required this.auth
  });

  @override
  List<Object> get props => [auth];

  @override
  String toString() => 'LoggedIn { user: $auth.user, token: $auth.accessToken}';
}

class LoggedOut extends AuthEvent {
  const LoggedOut();

  @override
  List<Object> get props => [];
}
