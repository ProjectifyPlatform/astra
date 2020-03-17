import 'package:astra/bloc/auth/auth_bloc.dart';
import 'package:astra/bloc/login/login_bloc.dart';
import 'package:astra/data/auth_repository.dart';
import 'package:astra/widgets/auth/loginForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final AuthRepository authRepository;

  LoginPage({
    Key key, @required this.authRepository,
  }): assert (authRepository != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authBloc: BlocProvider.of<AuthBloc>(context),
            repository: authRepository,
          );
        },

        child: LoginForm(),
      ),
    );
  }
}
