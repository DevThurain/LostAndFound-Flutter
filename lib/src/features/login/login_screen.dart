import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "login_screen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Center(
            child: Text('Login Screen'),
          ),
        ),
      ),
    );
  }
}
