import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/src/features/add_item/add_item_screen.dart';
import 'package:lost_and_found/src/features/based_screen/based_screen.dart';
import 'package:lost_and_found/src/features/home/home_screen.dart';
import 'package:lost_and_found/src/features/login/login_screen.dart';
import 'package:lost_and_found/src/features/register/register_screen.dart';
import 'package:lost_and_found/src/persistence/daos/user_dao.dart';

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

        case BasedScreen.routeName:
          return const BasedScreen();

        case AddItemScreen.routeName:
          return const AddItemScreen();

        default:
          if (FirebaseAuth.instance.currentUser == null) {
            return const LoginScreen();
          } else {
            return const BasedScreen();
          }
      }
    },
  );
}
