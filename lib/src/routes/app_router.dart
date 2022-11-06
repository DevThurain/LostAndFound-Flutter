import 'package:flutter/material.dart';
import 'package:lost_and_found/src/features/home/home_screen.dart';
import 'package:lost_and_found/src/features/login/login_screen.dart';
import 'package:lost_and_found/src/features/register/register_screen.dart';

Route<dynamic> AppRouter(RouteSettings routeSettings) {
  return MaterialPageRoute<void>(
    settings: routeSettings,
    builder: (BuildContext context) {
      switch (routeSettings.name) {
        case HomeScreen.routeName:
          return const HomeScreen();

        case LoginScreen.routeName:
          return const LoginScreen();

        case RegisterScreen.routeName:
          return const RegisterScreen();

        default:
          return const RegisterScreen();
      }
    },
  );
}
