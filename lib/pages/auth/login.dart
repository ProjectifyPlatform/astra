import 'package:astra/blocs/current_auth.dart';
import 'package:astra/models/auth.dart';
import 'package:astra/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();

  String _email = "";
  String _password = "";
  String _errorMsg;

  @override
  Widget build(BuildContext context) {
    final CurrentAuthBloc currentAuthBloc = Provider.of<CurrentAuthBloc>(context);

    final emailField = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: "",
      decoration: InputDecoration(
        hintText: "Email",
        contentPadding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
      ),
      onChanged: (String value) {
        setState(() {
          _email = value;
        });
      }
    );

    final passwordField = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: "",
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Password",
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
      ),
      onChanged: (String value) {
        setState(() {
          _password = value;
        });
      }
    );

    final loginButton = InkWell(
      onTap: () {},
      child: Container(
        height: 50.0,
        child: Center(
          child: Text("Login"),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Yes"),
      ),
      backgroundColor: Colors.white,
      body: Column(children: <Widget>[

        // Field values
        emailField,
        passwordField,
        loginButton,

        FlatButton(
          child: Text("Hemlo"),
          onPressed: () async {
            try {
              AuthResponse result = await _auth.login(_email, _password);
              currentAuthBloc.currentUser = result.user;
              currentAuthBloc.accessToken = result.accessToken;

            // Catch any exceptions
            } catch(e) {
              print(e.toString());
              setState(() {
                _errorMsg = e.toString();
              });
            }
          },
        )
      ],),
    );
  }
}