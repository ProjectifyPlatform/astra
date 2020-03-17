part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginFailure extends LoginState {
  final String errorMsg;
  const LoginFailure({
    @required this.errorMsg,
  });

  @override
  List<Object> get props => [errorMsg];
}
