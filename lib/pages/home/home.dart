import 'package:astra/blocs/current_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CurrentAuthBloc currentAuthBloc = Provider.of<CurrentAuthBloc>(context);

    return Container(
      child: Text("Hello")
    );
  }
}