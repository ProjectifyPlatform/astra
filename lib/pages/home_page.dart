import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:astra/bloc/auth/auth_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),

      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text("Simulate Logout"),
            onPressed: () {
              // Cause a loggedOut event.
              BlocProvider.of<AuthBloc>(context).add(LoggedOut());
            },
          ),
        ),
      ),
    );
  }
}