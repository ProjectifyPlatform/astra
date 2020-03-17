import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:astra/data/auth_repository.dart';
import 'package:astra/widgets/loadingIndicator.dart';

import 'package:astra/pages/auth/login_page.dart';
import 'package:astra/pages/home_page.dart';
import 'package:astra/pages/splash_page.dart';


import 'package:astra/bloc/auth/auth_bloc.dart';

class AppBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor.delegate = AppBlocDelegate();
  final authRepository = APIAuthRepository();

  runApp(
    BlocProvider<AuthBloc>(
      create: (context) {
        return AuthBloc(repository: authRepository)
          ..add(AppStarted());
      },
      child: App(authRepository: authRepository),
    ),
  );
}

class App extends StatelessWidget {
  final AuthRepository authRepository;

  App({Key key, @required this.authRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthUninitialized) {
          return SplashPage();
        }

        if (state is Authenticated) {
          return HomePage();
        }

        if (state is Unauthenticated) {
          return LoginPage(authRepository: authRepository);
        }

        // State is Authenticating
        return LoadingIndicator();
      },
    ),
  );
}