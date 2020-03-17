import 'dart:async';

import 'package:astra/bloc/auth/auth_bloc.dart';
import 'package:astra/data/model/auth.dart';
import 'package:astra/data/auth_repository.dart';
import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository repository;
  final AuthBloc authBloc;

  LoginBloc({
    @required this.repository,
    @required this.authBloc,
  }): assert(repository != null && authBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final Auth auth = await repository.login(
          email: event.email,
          password: event.password,
        );

        authBloc.add(LoggedIn(auth: auth));
        yield LoginInitial();
      } catch(error) {
        yield LoginFailure(errorMsg: error.toString());
      }
    }
  }
}
