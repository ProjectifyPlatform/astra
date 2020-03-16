import 'package:astra/blocs/current_auth.dart';
import 'package:astra/pages/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CurrentAuthBloc>.value(
      value: CurrentAuthBloc(),
      child: MaterialApp(
      home: Wrapper(),
    ));
  }
}
