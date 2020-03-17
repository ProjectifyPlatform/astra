import 'dart:async';

import 'package:astra/data/auth_repository.dart';
import 'package:astra/data/model/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';
part 'auth_event.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc({ @required this.repository }) : assert(repository != null);

  @override
  AuthState get initialState => AuthUninitialized();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool isAuthenticated = await repository.isAuthenticated();

      if (isAuthenticated) {
        yield Authenticated();
      } else {
        yield Unauthenticated();
      }
    }
    // AppStarted

    if (event is LoggedIn) {
      yield Authenticating();
      await repository.persistAuth(event.auth);
      yield Authenticated();
    }
    // LoggedIn

    if (event is LoggedOut) {
      yield Authenticating();
      await repository.deAuthenticate();
      yield Unauthenticated();
    }
    // Logout

  }
}
