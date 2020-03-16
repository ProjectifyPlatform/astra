import 'package:astra/blocs/current_auth.dart';
import 'package:astra/pages/auth/auth.dart';
import 'package:astra/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final CurrentAuthBloc currentAuthBloc = Provider.of<CurrentAuthBloc>(context);

    if (currentAuthBloc.currentUser == null || currentAuthBloc.accessToken == null) {
      return Auth();
    }

    return Home();
  }
}